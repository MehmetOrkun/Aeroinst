# ADB Ağ Aracı: Kullanım

Bu araç bilgisayardan USB ile telefona bağlanır. İki iş yapar:

| Seçenek | Ne yapar | Telefonda bir şey değiştirir mi? |
|---|---|---|
| **1. Teşhis raporu** | Wi-Fi sinyali (dBm), bağlı frekans ve hız, çevredeki GSB erişim noktaları, mobil sinyal (RSRP/RSRQ/SINR), ping ve paket kaybını `rapor.txt` dosyasına yazar | **Hayır** |
| **2. Önerilen ayarlar** | "Mobil veri her zaman etkin" ayarını açar. İstersen Özel DNS'i `one.one.one.one` yapar | Evet, ama önce eski değerleri yedekler |
| **3. Geri al** | Yedekten eski değerlere döner | Evet, eski hale getirir |

Root gerekmez, garantiyi bozmaz. Sadece Android'in kendi ayarlarını kullanır. Bu ayarları elle de yapabilirsin, bkz. rehberin [Bölüm 7](../README.md#7-geliştirici-seçenekleri)'si.

---

## Kurulum (bir kerelik, ~10 dakika)

### Telefonda

1. Ayarlar → Telefon hakkında → Yazılım bilgileri → **Yapım numarası**'na 7 kez dokun ve PIN'ini gir.
2. Ayarlar → **Geliştirici seçenekleri** → **USB hata ayıklama: AÇIK**.

### Bilgisayarda (Windows)

1. Bu klasörü indir. GitHub'da depo sayfasında **Code → Download ZIP** ile indirip zip'i aç.
2. Google'ın resmi **SDK Platform-Tools** paketini indir: <https://developer.android.com/tools/releases/platform-tools>. Sayfadaki "Download SDK Platform-Tools for Windows" bağlantısını kullan.
3. Zip'ten çıkan **`platform-tools`** klasörünü `s24fe-ag-araci.bat` dosyasının **yanına** koy. Görünüm şöyle olmalı:
   ```
   adb\
     s24fe-ag-araci.bat
     platform-tools\
       adb.exe
       ...
   ```
4. Telefonu USB kablosuyla bağla. Telefonda **"USB hata ayıklamaya izin verilsin mi?"** sorusu çıkar. "Bu bilgisayardan her zaman izin ver"i işaretle ve **İzin ver**'e dokun.
5. **`s24fe-ag-araci.bat`** dosyasına çift tıkla.

> Windows "Bilinmeyen yayıncı" uyarısı verirse "Ek bilgi → Yine de çalıştır" de. Dosyayı not defteriyle açıp ne yaptığını satır satır görebilirsin.

### macOS / Linux

```bash
cd s24fe-internet/adb
# platform-tools klasörünü buraya koy ya da adb'yi sistemine kur
chmod +x s24fe-ag-araci.sh
./s24fe-ag-araci.sh            # menü
./s24fe-ag-araci.sh rapor      # doğrudan rapor
./s24fe-ag-araci.sh uygula
./s24fe-ag-araci.sh geri-al
```

---

## Doğru rapor almak için

- Telefon **GSB WiFi'a bağlı ve giriş yapılmış** olsun.
- Telefonu odada **normalde kullandığın yerde** tut. USB kablosu izin verdiği kadar.
- İstersen iki rapor al: biri gündüz, biri akşam 21:00-23:00 arası. Arada fark varsa sorun sinyal değil GSB yoğunluğu.
- Raporu Claude'a yapıştırırsan ölçümlere göre kişiye özel öneri alırsın. Raporda telefon modelin, çevredeki Wi-Fi ağlarının isimleri ve MAC adresleri bulunur. Şifre, kişisel veri ya da GSB giriş bilgisi bulunmaz.

## Bittikten sonra

- **USB hata ayıklamayı kapatabilirsin.** Uygulanan ayarlar kalıcıdır.
- **Geliştirici seçeneklerinin ana anahtarını kapatma.** Kapatırsan Android bu menüdeki ayarları varsayılana döndürebilir. "Mobil veri her zaman etkin" ayarı da gidebilir.

## Sorun giderme

| Sorun | Çözüm |
|---|---|
| "adb bulunamadı" | `platform-tools` klasörü `.bat` dosyasının yanında değil. Kurulum 3. adıma bak. |
| "Telefon bulunamadı ya da izin verilmedi" | Kabloyu çıkar-tak ve telefondaki izin sorusunu onayla. Bazı kablolar sadece şarj eder, başka kablo dene. |
| Özel DNS sonrası GSB'de "internet yok" | Aracı aç, **3 (Geri al)** seç. Ya da telefonda Ayarlar → Bağlantılar → Diğer bağlantı ayarları → Özel DNS → **Otomatik**. |
| Raporda `cmd wifi ...` satırları hata veriyor | Bazı Samsung yazılımları bu komutları kısıtlıyor. Raporun geri kalanı yine işe yarar. |
