# Galaxy S24 FE: GSB WiFi ve Mobil Veri İyileştirme Rehberi

Kişi: KYK/GSB yurdu, Çubuk (Ankara). Telefon: Samsung Galaxy S24 FE.

Önce dürüst bir not: Hiçbir ayar ya da uygulama telefonun antenini fiziksel olarak güçlendiremez. "Sinyal artırıcı" diye satılan uygulamaların hepsi boş vaat. Gerçek iyileşme dört yerden gelir:

1. **Doğru teşhis.** Sorun sinyal mi, yoksa GSB'nin kendisi mi (kota, yoğun saat, tek cihaz sınırı)?
2. **Telefonun Wi-Fi'ı kısmasını engelleyen ayarlar** ve doğru bant seçimi.
3. **Konum ve kılıf.** Bedava ve çoğu zaman en etkili adım.
4. **Donanım ve operatör.** Wi-Fi için travel router veya USB anten, mobil için doğru operatör ve ağ modu. En büyük fark buradan çıkar.

> Menü adları One UI sürümüne göre biraz farklı olabilir. Bulamazsan Ayarlar'ın en üstündeki 🔍 arama kutusuna adını yaz.

---

## 0. Önce bunları yap (15 dakika)

- [ ] **Yazılımı güncelle:** Ayarlar → Yazılım güncelleme → İndir ve yükle. Modem yazılımı da bu güncellemeyle gelir.
- [ ] **Google Play sistem güncellemesi:** Ayarlar → Güvenlik ve gizlilik → Güncellemeler → Google Play sistem güncellemesi. Wi-Fi ve bağlantı modülleri de buradan güncellenir.
- [ ] **Wi-Fi güç tasarrufunu kapat:** Ayarlar → Bağlantılar → Wi-Fi → ⋮ → Akıllı Wi-Fi → **Wi-Fi güç tasarrufu modu: KAPALI**.
- [ ] **Kılıfı kontrol et:** Mıknatıslı, metal, kartlıklı ya da yüzüklü kılıf kullanıyorsan çıkarıp test et (bkz. [Bölüm 3](#3-konum-ve-kılıf-bedava-ve-en-etkili)).
- [ ] **GSB ağını "Ölçülü ağ" yap:** Arka planda kotanı yiyen yedekleme ve güncellemeleri durdurur (bkz. [2.3](#23-gsb-ağının-kendi-ayarları)).
- [ ] **VoLTE ve Wi-Fi aramasını aç:** Mobil sinyal zayıfken aramaların Wi-Fi üzerinden gitmesini sağlar (bkz. [5.3](#53-volte-ve-wi-fi-araması)).
- [ ] **Sinyal değerlerini ölç:** Sorunun gerçekten sinyal olup olmadığını öğren (bkz. [Bölüm 1](#1-teşhis-sorun-sinyal-mi-şebeke-mi)).
- [ ] **Odada en iyi noktayı bul:** Gizli "Connectivity Labs" menüsüyle yap (bkz. [2.2](#22-gizli-menü-connectivity-labs)).

---

## 1. Teşhis: Sorun sinyal mi, şebeke mi?

Bunu bilmeden yapılan her şey kör atış olur. GSB WiFi'da yavaşlığın büyük kısmı sinyalden değil ağın kendisinden gelir.

### 1.1 Wi-Fi sinyalini sayı olarak görme

**Yöntem A (önerilen):** Connectivity Labs → *Yakındaki Wi-Fi bilgileri* ([2.2](#22-gizli-menü-connectivity-labs)).

**Yöntem B:** Geliştirici seçeneklerini aç ([Bölüm 7](#7-geliştirici-seçenekleri)). Sonra *Wi-Fi ayrıntılı günlük kaydını etkinleştir* seçeneğini aç. Artık Wi-Fi listesinde ağın ayrıntısına girince dBm değeri görünür.

**Yöntem C:** Play Store'dan **WiFiAnalyzer (VREM Software)** uygulamasını kur. Açık kaynaklı ve reklamsız. Her GSB erişim noktasını (aynı isimli birden çok cihaz) ayrı ayrı, kanal ve bandıyla gösterir.

| Wi-Fi sinyali (RSSI) | Anlamı |
|---|---|
| −30 ile −55 dBm | Mükemmel |
| −55 ile −67 dBm | İyi. Video ve oyun sorunsuz olmalı |
| −67 ile −75 dBm | Zayıf. Yavaşlama başlar |
| −75 ile −85 dBm | Kötü. Kopmalar olur |
| −85 dBm'den kötü | Neredeyse kullanılamaz |

### 1.2 Mobil sinyali sayı olarak görme

Ayarlar → Telefon hakkında → Durum bilgisi → SIM kart durumu → **Sinyal gücü**.

| Mobil sinyal (4.5G / RSRP) | Anlamı |
|---|---|
| −85 dBm'den iyi | Mükemmel |
| −85 ile −95 dBm | İyi |
| −95 ile −105 dBm | Orta |
| −105 ile −115 dBm | Zayıf. Bina içinde tipik sorun |
| −115 dBm'den kötü | Çok kötü. Operatör veya konum değişmeli |

### 1.3 Hız testini doğru yap

[fast.com](https://fast.com) veya Speedtest uygulamasıyla aynı noktada **iki farklı saatte** test et. Örneğin bir testi öğlen 14:00'te, bir testi gece 22:00'de yap.

- Sinyal iyi (−65 dBm'den iyi) ama hız düşük, özellikle akşamları düşüyorsa sorun **GSB'nin yoğunluğu**. Bunu telefon ayarı çözmez.
- Sinyal kötüyse (−75 dBm'den kötü) sorun **konum veya anten**. Bölüm 3 ve 4 tam sana göre.

### 1.4 GSB'ye özgü kontroller

- **Kota:** Forum ve haber kaynaklarına göre GSB WiFi'da aylık kota var. Kaynaklarda 16 GB ile 32 GB arası değerler geçiyor. Kota dolunca hız çok düşüyor (kullanıcılar ~0,5 Mbps diyor). Güncel kotayı yurt yönetimine sor ya da GSB hesabından kontrol et. Ay sonuna doğru yavaşlıyorsa sebep büyük ihtimalle kota.
- **Tek cihaz sınırı:** Bazı kaynaklara göre aynı anda tek cihaz bağlanabiliyor. Laptopun GSB'ye bağlıyken telefon atılıyor ya da "maksimum cihaz" hatası alıyorsan sebep bu olabilir. Bir cihazda çıkış yapıp diğerinde giriş yap.
- **Giriş sayfası açılmıyorsa:** Tarayıcıda `http://neverssl.com` gibi şifresiz (http) bir site aç. Giriş sayfası genelde otomatik gelir.

### 1.5 Arkadaş telefonuyla karşılaştır

Aynı odada, **aynı operatörü** kullanan bir arkadaşının telefonuyla sinyal değerlerini (dBm) kıyasla.

- Onunki senden **10 dBm'den fazla** iyiyse telefonunda donanım sorunu olabilir. Bkz. [Bölüm 6](#6-yazılım-ve-donanım-arızası-kontrolü).
- İkisi de kötüyse sorun bina veya şebeke kaynaklı.

---

## 2. Wi-Fi ayarları

### 2.1 Akıllı Wi-Fi

Ayarlar → Bağlantılar → Wi-Fi → sağ üstte **⋮** → **Akıllı Wi-Fi**

| Ayar | Öneri | Neden |
|---|---|---|
| Wi-Fi güç tasarrufu modu | **KAPALI** | Açıkken telefon pil için Wi-Fi'ı kısıyor. Zayıf sinyalde kopma ve yavaşlamayı artırır. |
| Mobil veriye geç | **AÇIK**, mobil kotan yeterliyse | Wi-Fi çok kötüleşince internet kesilmez, mobil veriye geçer. Kotan azsa KAPALI bırak. |
| Wi-Fi'ı otomatik aç | İsteğe bağlı | Yurda gelince Wi-Fi kendiliğinden açılır. |
| Ağ kalitesi bilgilerini göster | **AÇIK** | Wi-Fi listesinde hangi ağın iyi olduğunu gösterir. |

### 2.2 Gizli menü: Connectivity Labs

Samsung'un gizli Wi-Fi menüsü. S24 FE'de One UI 7 ve sonrasında var.

1. Ayarlar → Bağlantılar → Wi-Fi → ⋮ → **Akıllı Wi-Fi**
2. En alta in. **"Akıllı Wi-Fi"** yazısına (sürüm numarasının olduğu satır) **art arda 7 kez** dokun.
3. Yeni bir **Connectivity Labs** bölümü açılır. Türkçe arayüzde "Bağlantı laboratuvarları" gibi görünebilir.

İşine yarayacaklar:

- **Yakındaki Wi-Fi bilgileri:** Çevredeki ağları ve sinyal kalitelerini (En iyi, İyi, Kötü, En kötü) kanalıyla birlikte listeler. Odanın içinde gezinerek **GSB sinyalinin en iyi olduğu noktayı** bul.
- **Ev Wi-Fi denetimi:** Bulunduğun alanın sinyal haritasını çıkarır, ölü noktaları gösterir.
- **Mobil veriye daha hızlı geçiş:** Wi-Fi bozulmaya başlar başlamaz mobil veriye geçer. Bağlantı kesintisiz olur ama mobil kotan daha hızlı biter. Sınırsız veya bol paketin varsa aç.

> Bu menüdeki "geliştirici" seçeneklerinin ne yaptığını bilmiyorsan dokunma. Samsung'un test amaçlı ayarları.

### 2.3 GSB ağının kendi ayarları

Wi-Fi listesinde GSB ağının yanındaki **⚙** simgesine dokun, gerekirse "Daha fazlasını görüntüle"yi aç.

- **Otomatik yeniden bağlan:** AÇIK
- **MAC adresi türü:** **Telefon MAC'si**. Rastgele MAC bazı portallarda tekrar tekrar giriş istemesine ve "farklı cihaz" sayılmaya yol açabiliyor. Sorun yaşamıyorsan dokunmana gerek yok.
- **Ölçülü ağ (Ölçülen ağ olarak algıla):** **Ölçülü olarak işle**. Telefon bu ağı "kotalı" sayar. Google Fotoğraflar yedeklemesi, büyük uygulama güncellemeleri ve arka plan indirmeleri gibi işleri kısar. GSB kotan ve bant genişliğin senin ön plandaki kullanımına kalır.
- **IP ayarları:** DHCP olarak bırak.

### 2.4 2.4 GHz mi, 5 GHz mi?

| | 2.4 GHz | 5 GHz |
|---|---|---|
| Duvardan geçme / menzil | **Daha iyi** | Zayıf |
| Hız (yakındayken) | Düşük | **Yüksek** |
| Kalabalık yurtta parazit | Çok | Az |

- Erişim noktası koridordaysa ve araya duvar/kapı giriyorsa **2.4 GHz genelde daha stabil** olur.
- Erişim noktasını görüyorsan, yani aynı koridorda veya kapının önündeysen **5 GHz** daha hızlıdır.
- Yurtta ayrı isimli bir 5 GHz ağı varsa (örneğin sonu "5G" ile biten bir GSB ağı) odanın içinde ikisini de dene. Hangisinde dBm daha iyiyse onu kullan, diğerini "Unut".
- Tek isim altında iki bant yayınlanıyorsa telefon otomatik seçer. Connectivity Labs veya WiFiAnalyzer'da hangi banda bağlı olduğunu görebilirsin.

### 2.5 Özel DNS (isteğe bağlı)

Sinyali artırmaz ama sitelerin açılmaya başlama süresini kısaltabilir ve DNS kaynaklı "internet yok" hatalarını azaltabilir.

Ayarlar → Bağlantılar → Diğer bağlantı ayarları → **Özel DNS** → *Özel DNS sağlayıcısı ana bilgisayar adı* → `one.one.one.one` (Cloudflare) veya `dns.google`

> ⚠️ **GSB uyarısı:** Bazı kurum ağları bu tür DNS'i engeller. Ayarı yaptıktan sonra GSB'de "Bağlı, internet yok" ya da "Özel DNS sunucusuna erişilemiyor" görürsen ayarı **Otomatik**e geri al. Giriş sayfası açılmazsa da önce Otomatik'e al, giriş yap, sonra tekrar dene.

### 2.6 Wi-Fi ayarlarını sıfırlama

Bağlantı tutarsızsa, sürekli düşüyorsa ya da giriş sayfası gelmiyorsa:

Ayarlar → Genel yönetim → Sıfırla → **Wi-Fi ve Bluetooth ayarlarını sıfırla**

Kayıtlı Wi-Fi şifreleri ve Bluetooth eşleşmeleri silinir. Fotoğraflar ve uygulamalar silinmez.

### 2.7 Küçük ama gerçek bir detay: Bluetooth

Telefon 2.4 GHz Wi-Fi'a bağlıyken Bluetooth kulaklık kullanmak Wi-Fi hızını biraz düşürebilir, çünkü ikisi aynı frekansı paylaşır. Oyun veya görüntülü görüşmede fark ediyorsan kablolu kulaklık dene ya da 5 GHz'e geç.

---

## 3. Konum ve kılıf: bedava ve en etkili

Telefonu odada 1-2 metre oynatmak çoğu zaman 10-15 dBm fark yaratır. Bu, hiçbir ayarın veremeyeceği kadar büyük bir iyileşme.

- **Erişim noktası nerede, öğren.** GSB cihazları genelde koridor tavanında olur. Odadaki en iyi nokta çoğunlukla **kapıya yakın ve yüksek** yerlerdir (ranzanın üst katı, dolap üstü). Pencere kenarı ise daha çok **mobil sinyal** için iyidir.
- **Telefonu masa ya da yatak üzerinde düz bırakmak yerine dik tut veya bir yere yasla.** Metal ranza, metal dolap ve beton kolon telefonla erişim noktası arasında kalmasın.
- **Kılıf:** Mıknatıslı (MagSafe tarzı) kılıflar, metal plakalı araç tutucu kılıfları, metal yüzükler ve kartlık cüzdan kılıflar sinyali bozabilir. Kılıfsız ölç, sonra kılıflı ölç. 5 dBm'den fazla fark varsa kılıfı değiştir. İnce silikon veya TPU kılıflar sorun çıkarmaz.
- **Tutuş:** Telefonun antenleri metal çerçevenin içinde. Özellikle yatay oyun oynarken üst ve alt kenarları avucunla tamamen kapatma.
- **Telefonu şarja en iyi sinyal noktasında tak.** Gece indirmeler oradayken yapılsın.

---

## 4. Wi-Fi için donanımla kesin çözüm

Ölçümlerinde odanın her yerinde −75 dBm'den kötü çıkıyorsa yazılımla yapılabilecekler bu kadar. Kalıcı çözüm, GSB sinyalini iyi çeken bir cihazı iyi noktaya koyup telefonu ona bağlamak.

> ⚠️ **Önce yurt yönetimine sor.** Kişisel router, modem veya repeater kullanımı yurt kurallarında yasak olabilir. Ayrıca bina ağında parazit yaratabilir. Yasaksa bu bölümü uygulama. İzin varsa kendi ağına mutlaka güçlü bir WPA2/WPA3 şifresi koy, açık ağ yayınlama.

### Seçenek A: Travel router (en temiz çözüm)

**Örnekler:** GL.iNet **GL-SFT1200 (Opal)** iyi bir fiyat/performans seçeneği. Daha güçlüsü GL.iNet **GL-MT3000 (Beryl AX)**.

Nasıl çalışır:

1. Router'ı odada GSB sinyalinin **en iyi olduğu yere** koyarsın, örneğin kapının üstündeki rafa.
2. Router'ın arayüzünde **Repeater** modunda GSB'ye bağlanırsın.
3. GSB giriş sayfası router'ın arayüzünden ya da router'a bağlı bir cihazdan açılır. Bir kez giriş yaparsın.
4. Telefonun artık metrelerce uzaktaki koridor cihazına değil, yanındaki router'a bağlanır.

Ne kazandırır: Router'ın antenleri telefonunkinden güçlüdür ve en iyi noktada sabit durur. Telefonda sinyal hep tam olur, kopmalar ciddi azalır.

Ne kazandırmaz: GSB'nin toplam hızını artırmaz. Akşam yoğunluğu ve kota aynen kalır.

### Seçenek B: Laptop + USB Wi-Fi adaptör (laptopun varsa)

1. Laptopa harici antenli bir USB Wi-Fi adaptör tak, örneğin TP-Link Archer T3U Plus.
2. USB uzatma kablosuyla adaptörü sinyalin iyi olduğu noktaya yerleştir.
3. Laptop GSB'ye bu adaptörle bağlansın.
4. Windows'ta Ayarlar → Ağ ve İnternet → **Mobil etkin nokta** ile laptopun internetini Wi-Fi olarak paylaş. Telefon bu ağa bağlanır.

Yurt kuralı uyarısı burada da geçerli.

### Seçenek C: Odanda Ethernet prizi varsa

Bazı yurtlarda odada kablolu internet prizi bulunur. Varsa ve kurallar izin veriyorsa, kablo bağlanan küçük bir router ya da laptop, Wi-Fi'dan çok daha stabil olur.

---

## 5. Mobil veri

### 5.1 Önce ölç

[1.2](#12-mobil-sinyali-sayı-olarak-görme)'deki yöntemle odanda, koridorda, pencere kenarında ve bina dışında ölç.

- Sadece bina içinde kötüyse sorun duvarlar. Pencere kenarı ve Wi-Fi araması (5.3) çözüm olur.
- Bina dışında da kötüyse sorun Çubuk'taki baz istasyonu kapsaması. Bu durumda en büyük etkiyi operatör değişikliği (5.7) yapar.

### 5.2 Ağ modu: 5G mi, 4.5G mi?

Türkiye'de 5G 1 Nisan 2026'da 81 il merkezinde başladı ve aşamalı olarak genişliyor. İlçelerde, yani Çubuk'ta da, 5G sinyali zayıf veya kenarda olabilir. Telefon zayıf 5G ile 4.5G arasında sürekli gidip gelirse bağlantı daha da kötüleşir.

Ayarlar → Bağlantılar → **Mobil ağlar** → **Ağ modu**

1. Bir gün **5G/LTE/3G/2G (otomatik)** ile kullan, bir gün **LTE/3G/2G (otomatik)** ile kullan.
2. Hangisinde daha az kopma ve daha iyi hız varsa onda kal.
3. Durum çubuğunda 5G simgesi sürekli gidip geliyorsa LTE moduna almak büyük ihtimalle daha iyi olur.

### 5.3 VoLTE ve Wi-Fi araması

- **VoLTE:** Ayarlar → Bağlantılar → Mobil ağlar → **VoLTE aramaları: AÇIK**. Arama sırasında telefon 4.5G'de kalır, internet kesilmez.
- **Wi-Fi araması (VoWiFi):** Telefon uygulaması → ⋮ → Ayarlar → **Wi-Fi araması: AÇIK**. Mobil sinyal çekmediğinde normal aramalar ve SMS GSB WiFi üzerinden gider.
  - **Turkcell**, resmi sayfasında Galaxy S24 FE'yi destekleniyor olarak listeliyor.
  - **Vodafone ve Türk Telekom'da** hizmetin hatta açık olması gerekebilir. Operatör uygulamasından veya müşteri hizmetlerinden "Wi-Fi arama" aktivasyonunu iste.
  - Seçenek görünmüyorsa önce telefonu güncelle.
  - GSB ağı bu trafiği engelliyorsa çalışmayabilir. Denemeden bilinmez.

### 5.4 Uçak modu hilesi

Telefon bazen uzaktaki kötü bir baz istasyonuna "yapışıp" kalır. Sinyal çubukları düşük ve hız sıfıra yakınsa uçak modunu 10 saniye açıp kapat. Telefon en iyi istasyonu baştan arar.

### 5.5 APN ve mobil ağ ayarlarını sıfırla

- **APN:** Ayarlar → Bağlantılar → Mobil ağlar → **Erişim Noktası Adları** → ⋮ → **Varsayılana sıfırla**
- Sorun sürüyorsa: Ayarlar → Genel yönetim → Sıfırla → **Mobil ağ ayarlarını sıfırla**

### 5.6 SIM kart

SIM kartın çok eskiyse (yıllar önce alınmışsa) operatör mağazasına git. **4.5G/5G uyumlu yeni SIM** veya **eSIM** iste, genelde ücretsizdir. Eski SIM kartlar yeni şebeke özelliklerinden tam yararlanamayabilir.

### 5.7 Operatör seçimi: mobilde en büyük fark

Aynı binada bir operatör tam çekerken diğeri hiç çekmeyebilir. Bunu ayar değil, o bölgedeki baz istasyonları belirler.

1. Yurttaki arkadaşlarına sor: "Odanda hangi operatör iyi çekiyor?" Bu en güvenilir bilgi.
2. Mümkünse farklı operatörlü bir arkadaşının SIM'ini kendi telefonuna takıp odanda 5 dakika dene. Sinyal gücünü (dBm) ve hız testini kıyasla.
3. Turkcell, Vodafone ve Türk Telekom'un sitelerindeki **kapsama haritalarına** yurdunun adresini gir. **nPerf** ve **Opensignal** gibi gerçek kullanıcı ölçümlü haritalara da bak.
4. Başka bir operatör açıkça daha iyiyse **numara taşıma** ile numaranı koruyarak geçebilirsin. Taşıma kampanyaları genelde daha ucuz da olur. Mevcut taahhüdün varsa cayma bedelini kontrol et.

### 5.8 Şikâyet et (işe yarıyor)

Operatörüne **kapsama şikâyeti** aç: uygulamadan veya müşteri hizmetlerinden, adresi ve "bina içinde çekmiyor" bilgisini vererek. Çok sayıda öğrenci aynı yurttan şikâyet ederse operatörler bölgeye kapasite ekleyebiliyor. Yurttaki arkadaşlarınla birlikte yapmak etkiyi artırır. Çözülmezse BTK'ya başvurabilirsin.

### 5.9 İleri seviye: bant kilitleme (isteğe bağlı, riskli değil ama garantisi yok)

Bazı Samsung telefonlarda telefon uygulamasına `*#2263#` yazınca gizli **bant seçimi** menüsü açılır. Bu yöntemin S24 FE'nin Exynos işlemcisinde ve güncel yazılımda çalıştığı doğrulanmış değil. Menü hiç açılmayabilir.

Açılırsa ne işe yarar: 4.5G'de **Band 20 (800 MHz)** duvarları en iyi geçen bant. Bina içinde sinyal çok zayıfsa yalnızca B20'ye kilitlemek bağlantıyı stabil yapabilir, ama hız düşer. **Band 3 (1800 MHz)** daha hızlı ama duvar geçişi daha zayıf.

> Emin değilsen bu adımı atla. Kilitleme sonrası sinyal tamamen giderse aynı menüden tüm bantları tekrar seç (otomatik) ya da telefonu yeniden başlat. Sorun sürerse "Mobil ağ ayarlarını sıfırla" (5.5) varsayılana döndürür.

### 5.10 ❌ "Sinyal güçlendirici / GSM repeater" ALMA

İnternette satılan ucuz cep telefonu sinyal güçlendiricileri operatör izni olmadan kullanılınca şebekeyi bozar ve çevredekilerin aramalarını, acil aramalar dahil, etkileyebilir. Birçok ülkede yalnızca operatörlerin kurmasına izin veriliyor, Türkiye'de de izne tabi. Hem yasal sorun çıkarabilir hem de genelde işe yaramaz. Bunun yerine Wi-Fi araması (5.3) ve operatör şikâyeti (5.8) kullan.

---

## 6. Yazılım ve donanım arızası kontrolü

- **Samsung Members** uygulaması → Destek → **Telefon tanılama**. Wi-Fi ve mobil ağ testlerini çalıştır.
- Arkadaşının aynı operatörlü telefonu aynı noktada belirgin şekilde daha iyi çekiyorsa ([1.5](#15-arkadaş-telefonuyla-karşılaştır)), özellikle telefon daha önce düştüyse anten bağlantısında sorun olabilir. Türkiye'de yasal garanti süresi 2 yıl. Faturan ve garantin devam ediyorsa **Samsung yetkili servisine** "Wi-Fi ve şebeke sinyali zayıf" diye götür.
- Servise gitmeden önce yedek al.

---

## 7. Geliştirici seçenekleri

**Açmak için:** Ayarlar → Telefon hakkında → Yazılım bilgileri → **Yapım numarası**'na 7 kez dokun ve PIN'ini gir. Artık Ayarlar'ın en altında **Geliştirici seçenekleri** var.

İçinde (aşağı kaydırıp "Ağ" bölümünü bul):

| Ayar | Öneri | Neden |
|---|---|---|
| Mobil veri her zaman etkin | **AÇIK** | Wi-Fi bozulduğunda mobil veriye geçiş anında olur, beklemezsin. Pile etkisi çok küçük. |
| Wi-Fi tarama azaltma | **KAPALI** | WiFiAnalyzer gibi uygulamalar sinyal ölçümünü daha sık yeniler. En iyi noktayı ararken işe yarar. |
| Wi-Fi ayrıntılı günlük kaydını etkinleştir | Ölçüm yaparken AÇIK, sonra KAPALI | Wi-Fi ayrıntılarında dBm değerini gösterir. |

Diğer ayarlara ne yaptıklarını bilmeden dokunma.

> **Geliştirici seçeneklerinin en üstteki ana anahtarını sonra KAPATMA.** Kapatırsan Android bu menüdeki ayarları varsayılana döndürebilir. USB hata ayıklamayı tek başına kapatmak sorun değil.

---

## 8. (İsteğe bağlı) Bilgisayardan ADB aracı

Bilgisayarın varsa [`adb/`](adb/) klasöründeki araç iki iş yapar:

1. **Teşhis raporu çıkarır, hiçbir ayarı değiştirmez:** Wi-Fi sinyali, bağlı olunan frekans, çevredeki GSB erişim noktaları, mobil sinyal (RSRP/RSRQ/SINR), ping ve paket kaybı. Raporu bana yapıştırırsan ölçümlere göre kişiye özel öneri verebilirim.
2. **Önerilen ayarları uygular:** "Mobil veri her zaman etkin" ve isteğe bağlı Özel DNS. Uygulamadan önce eski ayarları yedekler. Tek tuşla geri alınabilir.

Kurulum ve kullanım: [adb/KULLANIM.md](adb/KULLANIM.md)

---

## Kaynaklar

- [Android Authority: Samsung'un gizli Wi-Fi menüsü (Connectivity Labs)](https://www.androidauthority.com/samsung-phones-secret-wi-fi-settings-connectivity-labs-how-enable-3570045)
- [TechRadar: Connectivity Labs ile ölü nokta tespiti](https://techradar.com/phones/samsung-galaxy-phones/your-samsung-galaxy-phone-has-a-hidden-wi-fi-menu-that-lets-you-check-for-dead-zones-around-your-home-heres-how-to-find-it)
- [Turkcell: HD Ses ve Video Arama (VoLTE & VoWiFi) desteklenen cihazlar](https://www.turkcell.com.tr/servisler/hd-ses-ve-video-arama)
- [Türkiye'de 5G'nin 1 Nisan 2026'da 81 il merkezinde başlaması](https://meatechwatch.com/2026/04/02/turkiye-goes-live-with-5g-as-all-three-operators-launch-simultaneously-across-81-provincial-centres/)
- [GSB WiFi kota bilgisi (DonanımHaber)](https://www.donanimhaber.com/kyk-yurtlarinda-internet-kotasi-ne-kadar-oldu--144806)
- [GSB WiFi kota ve hız deneyimleri (Techolay forum)](https://techolay.net/sosyal/konu/kyk-yurt-interneti-hiz-ve-kotasi-kotu-mu.114341/)
- [GSB WiFi giriş ekranı açılmıyor sorunu (Tamindir)](https://www.tamindir.com/blog/wi-fi-giris-ekrani-acilmiyor-sorunu_91269/)
- [CellMapper: Samsung `*#2263#` bant seçimi notları](https://docs.cellmapper.net/mw/Special:MobileDiff/144816)
- [Belçika BIPT: GSM repeater kurulumu operatörlere özel (örnek düzenleme)](https://www.bipt.be/consumers/publication/bipt-emphasises-that-the-installation-and-use-of-gsm-or-umts-repeaters-is-strictly-reserved-for-mobile-operators)
