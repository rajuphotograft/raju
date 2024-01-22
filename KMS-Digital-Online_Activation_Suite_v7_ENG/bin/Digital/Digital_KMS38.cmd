@echo off
set ver=v7
title Digital ^& KMS 2038 Activation Windows 10 %ver% by mephistooo2 - TNCTR.com
mode con cols=70 lines=2
color 4e
IF "%1"=="-digi" GOTO :Digital
IF "%1"=="-kms38" GOTO :KMS38
:init
setlocal DisableDelayedExpansion
set cmdInvoke=1
set winSysFolder=System32
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
echo ADMIN RIGHTS ACTIVATE...
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
if '%cmdInvoke%'=='1' goto InvokeCmd 
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
goto ExecElevation

:InvokeCmd
ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
"%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
::===============================================================================================================
setlocal enabledelayedexpansion
setlocal EnableExtensions
pushd "%~dp0"
mode con cols=80 lines=41
color 5f
cd /d "%~dp0"
if /i "%PROCESSOR_ARCHITECTURE%"=="x86" if not defined PROCESSOR_ARCHITEW6432 set xOS=x86
for /f "tokens=2 delims==" %%a IN ('"wmic Path Win32_OperatingSystem Get Caption /format:LIST"')do (set NameOS=%%a) >nul 2>&1
for /f "tokens=2 delims==" %%a IN ('"wmic Path Win32_OperatingSystem Get CSDVersion /format:LIST"')do (set SP=%%a) >nul 2>&1
for /f "tokens=2 delims==" %%a IN ('"wmic Path Win32_OperatingSystem Get Version /format:LIST"')do (set Version=%%a) >nul 2>&1
for /f "tokens=2* delims= " %%a in ('reg query "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" /v "PROCESSOR_ARCHITECTURE"') do if "%%b"=="AMD64" (set vera=x64) else (set vera=x86)
:MAINMENU
echo ================================================================================
set ver=v7
set yy=%date:~-4%
set mm=%date:~-7,2%
set dd=%date:~-10,2%
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a:%%b)
echo                                                              %dd%.%mm%.%yy% ^- %mytime%
echo.
echo   Digital ^& KMS 2038 Activation Windows 10 %ver% - mephistooo2 - www.TNCTR.com 
echo.
echo   SUPPORT MICROSOFT PRUDUCTS:
echo   Windows 10 (all versions)
echo.
echo          OS NAME : %NameOS% %SP% %xOS%
reg.exe query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DigitalProductId >nul 2>&1
echo          VERSION : %Version%
echo    ARCHITECTURAL : %PROCESSOR_ARCHITECTURE%
echo          PC NAME : %computername%
echo ================================================================================
echo.
Echo.        [1] DIGITAL ACTIVATION START FOR WINDOWS 10 
Echo.
Echo.        [2] KMS38 ACTIVATION START FOR WINDOWS 10 
Echo.
Echo.        [3] DIGITAL or KMS38 $OEM$ ACTIVATION FOLDER EXTRACT TO DESKTOP
Echo.
Echo.        [4] WINDOWS ^& OFFICE ACTIVATION STATUS CHECK
Echo.
Echo.        [5] DIGITAL ACTIVATION VISIT WEBSITE (TNCTR)
Echo.
Echo.        [6] EXIT 
Echo.
Echo.        [7] RETURN KMS SUITE MENU
echo.
echo ================================================================================
choice /C:1234567 /N /M "YOUR CHOICE : "
if errorlevel 7 goto :KMSSuite
if errorlevel 6 goto :Exit 
if errorlevel 5 goto :TNCTR
if errorlevel 4 goto :Check
if errorlevel 3 goto :OEM
if errorlevel 2 goto :KMS38
if errorlevel 1 goto :Digital
::===============================================================================================================
:Digital
set "DIGI=1"
goto HWIDActivate
:KMS38
set "KMS38=1"
goto HWIDActivate
:HWIDActivate
mode con cols=75 lines=32
for /f "tokens=2 delims==" %%a in ('wmic path Win32_OperatingSystem get BuildNumber /value') do (
  set /a WinBuild=%%a
)

if %winbuild% LSS 10240 (
echo Not detected Windows 10. 
echo.
echo Digital License/KMS38 Activation is Not Supported.
)

CALL :DetectEdition

If defined KMS38 (
set "A2=KMS38"
set "A3=GVLK"
set "A4=Volume:GVLK"
set "A5=digi-ltsbc-kms38.exe"
set "A6= >nul 2>&1"
)
If defined DIGI (
set "B2=Digital License"
set "B3=Retail-OEM_Key"
set "B4=Retail"
set "B5=digi-ltsbc-kms38.exe"
)
::===========================================================
call:%A3%%B3%

for /f "tokens=1-4 usebackq" %%a in ("editions") do (if ^[%%a^]==^[%osedition%^] (
    set edition=%%a
    set sku=%%b 
    set Key=%%c
    goto:parseAndPatch))
echo:
echo %osedition% %vera% %A2%%B2% Activation is Not Supported.
echo:
Endlocal
del /f /q "editions"
pause
CLS
mode con cols=80 lines=41
GOTO MAINMENU
::===========================================================
:parseAndPatch
echo.
echo ===========================================================================
echo            Windows 10 %osedition% %vera% %A2%%B2% Activation
echo ===========================================================================
echo.
echo Cleaning ClipsSVC tokens...
sc stop clipsvc >nul 2>&1
del /f /s /q "%allusersprofile%\Microsoft\Windows\ClipSVC\tokens.dat" >nul 2>&1
echo.
echo Installing key %key%
cscript /nologo %windir%\system32\slmgr.vbs -ipk %key% >nul 2>&1
echo.

If defined DIGI (
ren bin\Rslc.dll slc.dll
)

If defined KMS38 (
ren bin\Vslc.dll slc.dll
)

echo Create GenuineTicket.XML file for Windows 10 %edition% %vera%

for /f "tokens=2 delims==" %%a IN ('"wmic Path Win32_OperatingSystem Get OperatingSystemSKU /format:LIST"')do (set SKU=%%a)
if not exist sku.txt echo | set /p "dummyName=%SKU%">bin\sku.txt
echo. >> bin\sku.txt

If defined DIGI (
echo Retail >> bin\sku.txt
)
If defined KMS38 (
echo Volume >> bin\sku.txt
)

cd bin\
start /wait digi-ltsbc-kms38.exe
timeout /t 3 >nul 2>&1
cd..

If defined DIGI (
ren bin\slc.dll Rslc.dll
)

If defined KMS38 (
ren bin\slc.dll Vslc.dll
)

If defined KMS38 (
cscript /nologo %windir%\system32\slmgr.vbs -ckms >nul 2>&1
)

echo.
echo GenuineTicket.XML file is installing for Windows 10 %edition% %vera%
clipup -v -o -altto %~dp0bin\
echo.

del /f /q bin\sku.txt >nul 2>&1
del /f /q "editions" >nul 2>&1

echo Activating...
echo.
cscript /nologo %windir%\system32\slmgr.vbs -ato >nul 2>&1
cscript /nologo %windir%\system32\slmgr.vbs -xpr
If defined DIGI goto :Done

for /f "tokens=2 delims==" %%A in ('"wmic path SoftwareLicensingProduct where (Description like '%%KMSCLIENT%%' and Name like 'Windows%%' and PartialProductKey is not NULL) get GracePeriodRemaining /VALUE" ') do set "gpr=%%A"
if %gpr% GTR 259200 echo Windows 10 %edition% %vera% is KMS38 activated. &goto:Done 
echo.
if %gpr% LEQ 259200 Goto:Rearm
:Rearm
echo Windows 10 %edition% %vera% KMS38 is not activated.
echo.
echo Applying slmgr /rearm to fix activation...
cscript /nologo %windir%\system32\slmgr.vbs -rearm >nul 2>&1
echo.
echo Restarting the system...
shutdown.exe /r /soft
echo.
::===============================================================================================================
:Done
echo.
echo Press any key to continue...
pause >nul
CLS
mode con cols=80 lines=41
GOTO MAINMENU
::===============================================================================================================
:DetectEdition
FOR /F "TOKENS=2 DELIMS==" %%A IN ('"WMIC PATH SoftwareLicensingProduct WHERE (Name LIKE 'Windows%%' AND PartialProductKey is not NULL) GET LicenseFamily /VALUE"') DO IF NOT ERRORLEVEL 1 SET "osedition=%%A"
if not defined osedition (FOR /F "TOKENS=3 DELIMS=: " %%A IN ('DISM /English /Online /Get-CurrentEdition 2^>nul ^| FIND /I "Current Edition :"') DO SET "osedition=%%A")

if %winbuild% EQU 10240 (
if "%osedition%"=="EnterpriseS" set "osedition=EnterpriseS2015"
if "%osedition%"=="EnterpriseSN" set "osedition=EnterpriseSN2015"
)
if %winbuild% EQU 14393 (
if "%osedition%"=="EnterpriseS" set "osedition=EnterpriseS2016"
if "%osedition%"=="EnterpriseSN" set "osedition=EnterpriseSN2016"
)
if %winbuild% GEQ 17763 (
if "%osedition%"=="EnterpriseS" set "osedition=EnterpriseS2019"
if "%osedition%"=="EnterpriseSN" set "osedition=EnterpriseSN2019"
)
exit /b
::===============================================================================================================
:Retail-OEM_Key
rem              Edition          SKU            Retail/OEM_Key         
(                                                                       
echo Core                         101      YTMG3-N6DKC-DKB77-7M9GH-8HVX7
echo CoreN                         98      4CPRK-NM3K3-X6XXQ-RXX86-WXCHW
echo CoreCountrySpecific           99      N2434-X9D7W-8PF6X-8DV9T-8TYMD
echo CoreSingleLanguage           100      BT79Q-G7N6G-PGBYW-4YWX6-6F4BT
echo Education                    121      YNMGQ-8RYV3-4PGQ3-C8XTP-7CFBY
echo EducationN                   122      84NGF-MHBT6-FXBX8-QWJK7-DRR8H
echo Enterprise                     4      XGVPP-NMH47-7TTHJ-W3FW7-8HV2C
echo EnterpriseN                   27      3V6Q6-NQXCX-V8YXR-9QCYV-QPFCT
echo EnterpriseS2015              125      FWN7H-PF93Q-4GGP8-M8RF3-MDWWW
echo EnterpriseSN2015             126      8V8WN-3GXBH-2TCMG-XHRX3-9766K
echo EnterpriseS2016              125      NK96Y-D9CD8-W44CQ-R8YTK-DYJWX
echo EnterpriseSN2016             126      2DBW3-N2PJG-MVHW3-G7TDK-9HKR4
echo Professional                  48      VK7JG-NPHTM-C97JM-9MPGT-3V66T
echo ProfessionalN                 49      2B87N-8KFHP-DKV6R-Y2C8J-PKCKT
echo ProfessionalEducation        164      8PTT6-RNW4C-6V7J2-C2D3X-MHBPB
echo ProfessionalEducationN       165      GJTYN-HDMQY-FRR76-HVGC7-QPF8P
echo ProfessionalWorkstation      161      DXG7C-N36C4-C4HTG-X4T3X-2YV77
echo ProfessionalWorkstationN     162      WYPNQ-8C467-V2W6J-TX4WX-WT2RQ
echo ServerRdsh                   175      NJCF7-PW8QT-3324D-688JX-2YV66
                                                                        
) > "editions" &exit /b                                                                                 
::===============================================================================================================
:GVLK
rem              Edition          SKU                  GVLK             
(                                                                       
echo Core                         101      TX9XD-98N7V-6WMQ6-BX7FG-H8Q99
echo CoreN                         98      3KHY7-WNT83-DGQKR-F7HPR-844BM
echo CoreCountrySpecific           99      PVMJN-6DFY6-9CCP6-7BKTT-D3WVR
echo CoreSingleLanguage           100      7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH
echo Education                    121      NW6C2-QMPVW-D7KKK-3GKT6-VCFB2
echo EducationN                   122      2WH4N-8QGBV-H22JP-CT43Q-MDWWJ
echo Enterprise                     4      NPPR9-FWDCX-D2C8J-H872K-2YT43
echo EnterpriseN                   27      DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4
echo EnterpriseS2016              125      DCPHK-NFMTC-H88MJ-PFHPY-QJ4BJ
echo EnterpriseSN2016             126      QFFDN-GRT3P-VKWWX-X7T3R-8B639
echo EnterpriseS2019              125      M7XTQ-FN8P6-TTKYV-9D4CC-J462D
echo EnterpriseSN2019             126      92NFX-8DJQP-P6BBQ-THF9C-7CG2H
echo Professional                  48      W269N-WFGWX-YVC9B-4J6C9-T83GX
echo ProfessionalN                 49      MH37W-N47XK-V7XM9-C7227-GCQG9
echo ProfessionalEducation        164      6TP4R-GNPTD-KYYHQ-7B7DP-J447Y
echo ProfessionalEducationN       165      YVWGF-BXNMC-HTQYQ-CPQ99-66QFC
echo ProfessionalWorkstation      161      NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J
echo ProfessionalWorkstationN     162      9FNHH-K3HBT-3W4TD-6383H-6XYWF
echo ServerStandard                 7      N69G4-B89J2-4G8F4-WWYCC-J464C
echo ServerStandardCore            13      N69G4-B89J2-4G8F4-WWYCC-J464C
echo ServerDatacenter               8      WMDGN-G9PQG-XVVXX-R3X43-63DFG
echo ServerDatacenterCore          12      WMDGN-G9PQG-XVVXX-R3X43-63DFG
echo ServerSolution                52      WVDHN-86M7X-466P6-VHXV7-YY726
echo ServerSolutionCore            53      WVDHN-86M7X-466P6-VHXV7-YY726
echo ServerRdsh                   175      7NBT4-WGBQX-MP4H7-QXFF8-YP3KX

) > "editions" &exit /b   
::===============================================================================================================
:OEM
Echo.
Echo.   [1] DIGITAL $OEM$       [2] KMS38 $OEM$
Echo.
choice /C:12 /N /M "YOUR CHOICE : "
if errorlevel 2 goto :KMS38OEM 
if errorlevel 1 goto :DIGIOEM

:DIGIOEM
cd /d "%userprofile%\desktop\"
IF EXIST $OEM$ (
echo.
echo ===============================================
echo $OEM$ folder already exists on Desktop.
echo ===============================================
echo. 
echo Press any key to continue...
pause >nul
CLS
mode con cols=80 lines=41
GOTO MAINMENU
) ELSE (
md %userprofile%\desktop\$OEM$
cd /d "%~dp0"
md %userprofile%\desktop\$OEM$\$$\Setup\Scripts\bin\
xcopy OEM_Digital\* %userprofile%\desktop\ /s /i /y >nul 2>&1
xcopy /cryi bin\* %userprofile%\desktop\$OEM$\$$\Setup\Scripts\bin\) >nul 2>&1 
ren %userprofile%\desktop\$OEM$\$$\Setup\Scripts\bin\Rslc.dll slc.dll
del %userprofile%\desktop\$OEM$\$$\Setup\Scripts\bin\Vslc.dll
echo MSGBOX "DIGITAL ACTIVATION $OEM$ FOLDER EXTRACT TO DESKTOP." > %temp%\TEMPmessage.vbS
call %temp%\TEMPmessage.vbs
del %temp%\TEMPmessage.vbs /f /q
CLS
mode con cols=80 lines=41
GOTO MAINMENU

:KMS38OEM
cd /d "%userprofile%\desktop\"
IF EXIST $OEM$ (
echo.
echo ===============================================
echo $OEM$ folder already exists on Desktop.
echo ===============================================
echo. 
echo Press any key to continue...
pause >nul
CLS
mode con cols=80 lines=41
GOTO MAINMENU
) ELSE (
md %userprofile%\desktop\$OEM$
cd /d "%~dp0"
md %userprofile%\desktop\$OEM$\$$\Setup\Scripts\bin\
xcopy OEM_KMS38\* %userprofile%\desktop\ /s /i /y >nul 2>&1
xcopy /cryi bin\* %userprofile%\desktop\$OEM$\$$\Setup\Scripts\bin\) >nul 2>&1 
ren %userprofile%\desktop\$OEM$\$$\Setup\Scripts\bin\Vslc.dll slc.dll
del %userprofile%\desktop\$OEM$\$$\Setup\Scripts\bin\Rslc.dll
echo MSGBOX "KMS38 ACTIVATION $OEM$ FOLDER EXTRACT TO DESKTOP." > %temp%\TEMPmessage.vbS
call %temp%\TEMPmessage.vbs
del %temp%\TEMPmessage.vbs /f /q
CLS
mode con cols=80 lines=41
GOTO MAINMENU

::===============================================================================================================
:Check
set spp=SoftwareLicensingProduct
set sps=SoftwareLicensingService
set ospp=OfficeSoftwareProtectionProduct
set osps=OfficeSoftwareProtectionService
set winApp=55c92734-d682-4d71-983e-d6ec3f16059f
set o14App=59a52881-a989-479d-af46-f275c6370663
set o15App=0ff1ce15-a989-479d-af46-f275c6370663
for %%a in (spp_get,ospp_get,Windows,sppw,0ff1ce15,sppo,osppsvc,ospp14,ospp15) do set "%%a="
for /f "tokens=6 delims=[]. " %%G in ('ver') do set winbuild=%%G
set "spp_get=Description, DiscoveredKeyManagementServiceMachineName, DiscoveredKeyManagementServiceMachinePort, EvaluationEndDate, GracePeriodRemaining, ID, KeyManagementServiceMachine, KeyManagementServicePort, KeyManagementServiceProductKeyID, LicenseStatus, LicenseStatusReason, Name, PartialProductKey, ProductKeyID, VLActivationInterval, VLRenewalInterval"
if %winbuild% geq 9200 set "spp_get=%spp_get%, DiscoveredKeyManagementServiceMachineIpAddress, KeyManagementServiceLookupDomain, ProductKeyChannel, VLActivationTypeEnabled"
set "ospp_get=Description, DiscoveredKeyManagementServiceMachineName, DiscoveredKeyManagementServiceMachinePort, EvaluationEndDate, GracePeriodRemaining, ID, KeyManagementServiceMachine, KeyManagementServicePort, KeyManagementServiceProductKeyID, LicenseStatus, LicenseStatusReason, Name, PartialProductKey, ProductKeyID, VLActivationInterval, VLRenewalInterval"

set "SysPath=%Windir%\System32"
if exist "%Windir%\Sysnative\reg.exe" (set "SysPath=%Windir%\Sysnative")
set "Path=%SysPath%;%Windir%;%SysPath%\Wbem;%SysPath%\WindowsPowerShell\v1.0\"

call :PKey %spp% %winApp% Windows sppw
if %winbuild% geq 9200 call :PKey %spp% %o15App% 0ff1ce15 sppo
wmic path %osps% get Version 1>nul 2>nul && (
call :PKey %ospp% %o14App% osppsvc ospp14
if %winbuild% lss 9200 call :PKey %ospp% %o15App% osppsvc ospp15
)

:SPP
echo.
echo ********************************************************************************
echo ***                       Windows Activation Status                          ***
echo ********************************************************************************
if not defined Windows (
echo.
slmgr /xpr
goto :SPPo
)
for /f "tokens=2 delims==" %%a in ('"wmic path %spp% where (ApplicationID='%winApp%' and PartialProductKey is not null) get ID /value"') do (
  set "chkID=%%a"
  call :Property "%spp%" "%sps%" "%spp_get%"
  call :Output
  echo.
)

:SPPo
set verbose=1
if not defined 0ff1ce15 (
if defined osppsvc goto :OSPP
cls
goto :MAINMENU
)
echo ********************************************************************************
echo ***                       Office Activation Status                           ***
echo ********************************************************************************
for /f "tokens=2 delims==" %%a in ('"wmic path %spp% where (ApplicationID='%o15App%' and PartialProductKey is not null) get ID /value"') do (
  set "chkID=%%a"
  call :Property "%spp%" "%sps%" "%spp_get%"
  call :Output
  cls
  call :MAINMENU
  echo.
)
set verbose=0
if defined osppsvc goto :OSPP
goto :End

:OSPP
echo ********************************************************************************
echo ***                       Office Activation Status                           ***
echo ********************************************************************************

if defined ospp15 for /f "tokens=2 delims==" %%a in ('"wmic path %ospp% where (ApplicationID='%o15App%' and PartialProductKey is not null) get ID /value"') do (
  set "chkID=%%a"
  call :Property "%ospp%" "%osps%" "%ospp_get%"
  call :Output
  cls
  call :MAINMENU
  echo.
)
if defined ospp14 for /f "tokens=2 delims==" %%a in ('"wmic path %ospp% where (ApplicationID='%o14App%' and PartialProductKey is not null) get ID /value"') do (
  set "chkID=%%a"
  call :Property "%ospp%" "%osps%" "%ospp_get%"
  call :Output
  cls
  call :MAINMENU
  echo.
)
goto :End

:PKey
wmic path %1 where (ApplicationID='%2' and PartialProductKey is not null) get ID /value 2>nul | findstr /i ID 1>nul && (set %3=1&set %4=1)
exit /b

:Property
for %%a in (%~3) do set "%%a="
if %~1 equ %ospp% for %%a in (DiscoveredKeyManagementServiceMachineIpAddress, KeyManagementServiceLookupDomain, ProductKeyChannel, VLActivationTypeEnabled) do set "%%a="
set "KmsClient="
for /f "tokens=* delims=" %%a in ('"wmic path %~1 where (ID='%chkID%') get %~3 /value" ^| findstr ^=') do set "%%a"

set /a gprDays=%GracePeriodRemaining%/1440
echo %Description%| findstr /i VOLUME_KMSCLIENT 1>nul && (set KmsClient=1)
call cmd /c exit /b %LicenseStatusReason%
set "LicenseReason=%=ExitCode%"

if %LicenseStatus%==0 (
set "License=LISANSLI DEGIL"
set "LicenseMsg="
)
if %LicenseStatus%==1 (
set "License=LISANSLI"
set "LicenseMsg="
if not %GracePeriodRemaining%==0 set "LicenseMsg=LISANS SONA ERME SURESI : %GracePeriodRemaining% dakika (%gprDays% gun)"
)
if %LicenseStatus%==2 (
set "License=ILK ODEMESIZ DONEM"
set "LicenseMsg=Kalan sure: %GracePeriodRemaining% dakika (%gprDays% gun)"
)
if %LicenseStatus%==3 (
set "License=EK ODEMESIZ DONEM (KMS LISANSININ SURESI DOLMUS)"
set "LicenseMsg=Kalan sure: %GracePeriodRemaining% dakika (%gprDays% gun)"
)
if %LicenseStatus%==4 (
set "License=ORIJINAL OLMAYAN ODEMESIZ DONEM."
set "LicenseMsg=Kalan sure: %GracePeriodRemaining% dakika (%gprDays% gun)"
)
if %LicenseStatus%==6 (
set "License=UZATILMIS ODEMESIZ DONEM"
set "LicenseMsg=Kalan sure: %GracePeriodRemaining% dakika (%gprDays% gun)"
)
if %LicenseStatus%==5 (
set "License=BILDIRIM MODU"
  if "%LicenseReason%"=="C004F200" (set "LicenseMsg=Notification Reason: 0xC004F200 (non-genuine)."
  ) else if "%LicenseReason%"=="C004F009" (set "LicenseMsg=Notification Reason: 0xC004F009 (grace time expired)."
  ) else (set "LicenseMsg=Notification Reason: 0x%LicenseReason%"
  )
)
if %LicenseStatus% gtr 6 (
set "License=Unknown"
set "LicenseMsg="
)
if not defined KmsClient exit /b

if %KeyManagementServicePort%==0 set KeyManagementServicePort=1688
set "KmsReg=Kaydedilen KMS Sunucu Ismi : %KeyManagementServiceMachine%:%KeyManagementServicePort%"
if "%KeyManagementServiceMachine%"=="" set "KmsReg=Kaydedilen KMS Sunucu Ismi : KMS ismi mevcut degil"

if %DiscoveredKeyManagementServiceMachinePort%==0 set DiscoveredKeyManagementServiceMachinePort=1688
set "KmsDns=KMS machine name from DNS: %DiscoveredKeyManagementServiceMachineName%:%DiscoveredKeyManagementServiceMachinePort%"
if "%DiscoveredKeyManagementServiceMachineName%"=="" set "KmsDns=DNS Otomatik Kesif         : KMS ismi mevcut degil"

for /f "tokens=* delims=" %%a in ('"wmic path %~2 get ClientMachineID, KeyManagementServiceHostCaching /value" ^| findstr ^=') do set "%%a"
if /i %KeyManagementServiceHostCaching%==True (set KeyManagementServiceHostCaching=Etkin) else (set KeyManagementServiceHostCaching=Etkin degil)

if %winbuild% lss 9200 exit /b
if %~1 equ %ospp% exit /b

if "%DiscoveredKeyManagementServiceMachineIpAddress%"=="" set "DiscoveredKeyManagementServiceMachineIpAddress=Kullanilabilir degil"

if "%KeyManagementServiceLookupDomain%"=="" set "KeyManagementServiceLookupDomain="

if %VLActivationTypeEnabled%==3 (
set VLActivationType=Token
) else if %VLActivationTypeEnabled%==2 (
set VLActivationType=KMS
) else if %VLActivationTypeEnabled%==1 (
set VLActivationType=AD
) else (
set VLActivationType=All
)
exit /b

:Output
slmgr /xpr %ID% | slmgr /dli %ID%

:End
echo.
exit /b
::===============================================================================================================
:TNCTR
echo.
start https://www.tnctr.com/topic/450916-kms-dijital-online-aktivasyon-suite-v52/
CLS
GOTO MAINMENU
::===============================================================================================================
:Exit
echo.
echo MSGBOX "SPECIAL THANKS : TNCTR Family - CODYQX4, abbodi1406, qewlpal, s1ave77, cynecx, qad, Mouri_Naruto (MDL)", vbInformation,"..:: mephistooo2 | TNCTR ::.."  > %temp%\TEMPmessage.vbs
call %temp%\TEMPmessage.vbs
del %temp%\TEMPmessage.vbs /f /q
ENDLOCAL
exit
::===============================================================================================================
:KMSSuite
cd..
cd..
call KMS_Suite.cmd
ENDLOCAL
exit