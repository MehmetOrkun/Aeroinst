@echo off
REM S24 FE ag araci - Windows
REM Cift tikla. Menuden: 1 rapor, 2 ayarlari uygula, 3 geri al.
setlocal EnableExtensions
title S24 FE Ag Araci

set "BASE=%~dp0"
set "YEDEK=%BASE%yedek"
set "RAPOR=%BASE%rapor.txt"

where adb >nul 2>nul
if not errorlevel 1 goto adb_ok
if exist "%BASE%platform-tools\adb.exe" goto adb_local
echo.
echo [HATA] adb bulunamadi.
echo Google "SDK Platform-Tools" paketini indir:
echo   https://developer.android.com/tools/releases/platform-tools
echo Zip'ten cikan "platform-tools" klasorunu bu dosyanin yanina koy.
echo.
pause
exit /b 1

:adb_local
set "PATH=%BASE%platform-tools;%PATH%"

:adb_ok
adb start-server >nul 2>nul
adb get-state >nul 2>nul
if not errorlevel 1 goto menu
echo.
echo [HATA] Telefon bulunamadi ya da izin verilmedi.
echo  - USB kablosunu tak, telefonda "USB hata ayiklama" acik olsun.
echo  - Telefonda cikan "USB hata ayiklamaya izin ver" sorusuna IZIN VER de.
echo  - Sonra bu dosyayi tekrar calistir.
echo.
pause
exit /b 1

:menu
echo.
echo ============================================
echo   S24 FE Ag Araci
echo ============================================
echo   1 - Teshis raporu olustur  [hicbir ayari degistirmez]
echo   2 - Onerilen ayarlari uygula
echo   3 - Uygulanan ayarlari geri al
echo   4 - Cikis
echo.
choice /c 1234 /n /m "Secimin [1-4]: "
if errorlevel 4 goto end
if errorlevel 3 goto revert
if errorlevel 2 goto apply
goto report

:report
echo.
echo Rapor hazirlaniyor, yaklasik 40 saniye surer. Telefonu ellemeden bekle...
> "%RAPOR%" echo ==== S24 FE AG RAPORU ====
>>"%RAPOR%" echo Tarih: %date% %time%
call :baslik "Cihaz"
adb shell "for p in ro.product.model ro.build.display.id gsm.version.baseband gsm.operator.alpha gsm.network.type; do echo $p = $(getprop $p); done" >>"%RAPOR%" 2>&1
call :baslik "Wi-Fi durumu"
adb shell cmd wifi status >>"%RAPOR%" 2>&1
call :baslik "Cevredeki Wi-Fi aglari"
adb shell cmd wifi start-scan >nul 2>&1
adb shell sleep 6
adb shell cmd wifi list-scan-results >>"%RAPOR%" 2>&1
call :baslik "Mobil sinyal"
adb shell "dumpsys telephony.registry | grep -i -E 'msignalstrength|mservicestate' | head -n 6" >>"%RAPOR%" 2>&1
call :baslik "Ag ayarlari"
adb shell "for k in mobile_data_always_on private_dns_mode private_dns_specifier; do echo $k = $(settings get global $k); done" >>"%RAPOR%" 2>&1
call :baslik "Ping 8.8.8.8 - 15 paket"
adb shell ping -c 15 8.8.8.8 >>"%RAPOR%" 2>&1
call :baslik "DNS ve ping www.google.com"
adb shell ping -c 4 www.google.com >>"%RAPOR%" 2>&1
echo.
echo [OK] Rapor hazir: %RAPOR%
start "" notepad "%RAPOR%"
goto menu

:apply
if not exist "%YEDEK%\" mkdir "%YEDEK%"
REM Yalnizca ilk uygulamada yedeklenir; boylece geri al hep orijinal degerlere doner.
call :yedekle mobile_data_always_on
call :yedekle private_dns_mode
call :yedekle private_dns_specifier
adb shell settings put global mobile_data_always_on 1
echo [OK] "Mobil veri her zaman etkin" ACILDI.
echo.
echo Ozel DNS: Cloudflare one.one.one.one
echo   Bazi kurum aglari bunu engeller. GSB'de "internet yok" gorursen
echo   bu araci acip 3 numarayla geri al.
choice /c EH /n /m "Ozel DNS ayarlansin mi? [E/H]: "
if errorlevel 2 goto apply_nodns
adb shell settings put global private_dns_specifier one.one.one.one
adb shell settings put global private_dns_mode hostname
echo [OK] Ozel DNS ayarlandi: one.one.one.one
goto apply_done
:apply_nodns
echo Ozel DNS degistirilmedi.
:apply_done
echo.
echo Ayarlar uygulandi. Eski degerler "%YEDEK%" klasorune yedeklendi.
goto menu

:revert
if exist "%YEDEK%\" goto revert_go
echo.
echo Geri alinacak yedek yok. Ayarlar zaten degistirilmemis.
goto menu
:revert_go
REM DNS adresi moddan once geri yuklenir.
call :geriyukle mobile_data_always_on
call :geriyukle private_dns_specifier
call :geriyukle private_dns_mode
rd /s /q "%YEDEK%"
echo.
echo [OK] Tum ayarlar eski haline dondu.
goto menu

:end
endlocal
exit /b 0

REM ---------- alt programlar ----------

:baslik
>>"%RAPOR%" echo.
>>"%RAPOR%" echo ---- %~1 ----
goto :eof

:yedekle
if exist "%YEDEK%\%~1.txt" goto :eof
adb shell settings get global %~1 > "%YEDEK%\%~1.txt" 2>nul
goto :eof

:geriyukle
set "VAL="
if not exist "%YEDEK%\%~1.txt" goto :eof
for /f "usebackq delims=" %%A in ("%YEDEK%\%~1.txt") do if not defined VAL set "VAL=%%A"
if not defined VAL set "VAL=null"
echo(%VAL%| findstr /r /x "[A-Za-z0-9._-]*" >nul
if errorlevel 1 goto geriyukle_bad
if /i "%VAL%"=="null" goto geriyukle_delete
adb shell settings put global %~1 %VAL%
echo [OK] %~1 eski haline dondu: %VAL%
goto :eof
:geriyukle_delete
adb shell settings delete global %~1 >nul 2>&1
echo [OK] %~1 varsayilana dondu.
goto :eof
:geriyukle_bad
echo [UYARI] %~1 yedegi okunamadi, atlandi.
goto :eof
