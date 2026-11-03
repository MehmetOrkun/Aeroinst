#!/usr/bin/env bash
# S24 FE ağ aracı (macOS / Linux)
#   ./s24fe-ag-araci.sh            -> menü
#   ./s24fe-ag-araci.sh rapor      -> teşhis raporu (hiçbir ayarı değiştirmez)
#   ./s24fe-ag-araci.sh uygula     -> önerilen ayarları uygula (önce yedekler)
#   ./s24fe-ag-araci.sh geri-al    -> yedekten eski ayarlara dön
set -u

DIR="$(cd "$(dirname "$0")" && pwd)"
YEDEK="$DIR/yedek"
RAPOR="$DIR/rapor.txt"
ADB="${ADB:-adb}"
AYARLAR="mobile_data_always_on private_dns_mode private_dns_specifier"

if ! command -v "$ADB" >/dev/null 2>&1; then
  if [ -x "$DIR/platform-tools/adb" ]; then
    ADB="$DIR/platform-tools/adb"
  else
    echo "[HATA] adb bulunamadı."
    echo "Google 'SDK Platform-Tools' paketini indir:"
    echo "  https://developer.android.com/tools/releases/platform-tools"
    echo "Zip'ten çıkan 'platform-tools' klasörünü bu dosyanın yanına koy."
    exit 1
  fi
fi

telefon() { "$ADB" shell "$@" 2>&1 | tr -d '\r'; }
baslik() { printf '\n---- %s ----\n' "$1"; }

cihaz_kontrol() {
  "$ADB" start-server >/dev/null 2>&1
  if [ "$("$ADB" get-state 2>/dev/null | tr -d '\r')" != "device" ]; then
    echo "[HATA] Telefon bulunamadı ya da izin verilmedi."
    echo " - USB kablosunu tak, telefonda 'USB hata ayıklama' açık olsun."
    echo " - Telefonda çıkan 'USB hata ayıklamaya izin ver' sorusuna İZİN VER de."
    exit 1
  fi
}

rapor() {
  echo "Rapor hazırlanıyor, yaklaşık 40 saniye sürer. Telefonu ellemeden bekle..."
  {
    echo "==== S24 FE AĞ RAPORU ===="
    echo "Tarih: $(date '+%Y-%m-%d %H:%M:%S')"
    baslik "Cihaz"
    telefon "for p in ro.product.model ro.build.display.id gsm.version.baseband gsm.operator.alpha gsm.network.type; do echo \$p = \$(getprop \$p); done"
    baslik "Wi-Fi durumu"
    telefon cmd wifi status
    baslik "Çevredeki Wi-Fi ağları"
    telefon cmd wifi start-scan >/dev/null
    sleep 6
    telefon cmd wifi list-scan-results
    baslik "Mobil sinyal"
    telefon "dumpsys telephony.registry | grep -i -E 'msignalstrength|mservicestate' | head -n 6"
    baslik "Ağ ayarları"
    telefon "for k in $AYARLAR; do echo \$k = \$(settings get global \$k); done"
    baslik "Ping 8.8.8.8 - 15 paket"
    telefon ping -c 15 8.8.8.8
    baslik "DNS ve ping www.google.com"
    telefon ping -c 4 www.google.com
  } > "$RAPOR"
  echo "[OK] Rapor hazır: $RAPOR"
}

uygula() {
  mkdir -p "$YEDEK"
  # Yalnızca ilk uygulamada yedekle; böylece "geri al" hep orijinal değerlere döner.
  for k in $AYARLAR; do
    [ -f "$YEDEK/$k.txt" ] || telefon settings get global "$k" > "$YEDEK/$k.txt"
  done

  telefon settings put global mobile_data_always_on 1
  echo "[OK] 'Mobil veri her zaman etkin' AÇILDI."

  echo
  echo "Özel DNS: Cloudflare one.one.one.one"
  echo "  Bazı kurum ağları bunu engeller. GSB'de 'internet yok' görürsen"
  echo "  bu aracı açıp 'geri-al' ile geri al."
  read -r -p "Özel DNS ayarlansın mı? [e/H]: " c || c=""
  case "$c" in
    e|E)
      telefon settings put global private_dns_specifier one.one.one.one
      telefon settings put global private_dns_mode hostname
      echo "[OK] Özel DNS ayarlandı: one.one.one.one"
      ;;
    *) echo "Özel DNS değiştirilmedi." ;;
  esac
  echo
  echo "Ayarlar uygulandı. Eski değerler '$YEDEK' klasörüne yedeklendi."
}

geri_al() {
  if [ ! -d "$YEDEK" ]; then
    echo "Geri alınacak yedek yok. Ayarlar zaten değiştirilmemiş."
    return
  fi
  # DNS adresi moddan önce geri yüklenir ki mod değişince doğru adres hazır olsun.
  for k in mobile_data_always_on private_dns_specifier private_dns_mode; do
    f="$YEDEK/$k.txt"
    [ -f "$f" ] || continue
    v="$(head -n 1 "$f" | tr -d '[:space:]')"
    [ -n "$v" ] || v="null"
    if ! printf '%s' "$v" | grep -Eq '^[A-Za-z0-9._-]+$'; then
      echo "[UYARI] $k yedeği okunamadı, atlandı."
      continue
    fi
    if [ "$v" = "null" ]; then
      telefon settings delete global "$k" >/dev/null
      echo "[OK] $k varsayılana döndü."
    else
      telefon settings put global "$k" "$v"
      echo "[OK] $k eski haline döndü: $v"
    fi
  done
  rm -rf "$YEDEK"
  echo "[OK] Tüm ayarlar eski haline döndü."
}

cihaz_kontrol
case "${1:-}" in
  rapor) rapor; exit 0 ;;
  uygula) uygula; exit 0 ;;
  geri-al) geri_al; exit 0 ;;
  "") ;;
  *) echo "Kullanım: $0 [rapor|uygula|geri-al]"; exit 1 ;;
esac

while true; do
  echo
  echo "============================================"
  echo "  S24 FE Ağ Aracı"
  echo "============================================"
  echo "  1 - Teşhis raporu oluştur  [hiçbir ayarı değiştirmez]"
  echo "  2 - Önerilen ayarları uygula"
  echo "  3 - Uygulanan ayarları geri al"
  echo "  4 - Çıkış"
  read -r -p "Seçimin [1-4]: " s || exit 0
  case "$s" in
    1) rapor ;;
    2) uygula ;;
    3) geri_al ;;
    4|q|Q) exit 0 ;;
    *) echo "Geçersiz seçim." ;;
  esac
done
