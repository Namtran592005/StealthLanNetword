@echo off
setlocal enabledelayedexpansion

echo =================================================================
echo       KHOI PHUC CAU HINH MANG VE TRANG THAI BINH THUONG
echo =================================================================
echo.
echo [*] Kich ban nay se go bo cac thiet lap an minh va dua he thong
echo [*] tro ve trang thai hoat dong mang mac dinh.
echo [*] Chay voi quyen Quan tri vien (Run as Administrator) la BAT BUOC.
echo.
pause
cls

echo [*] Dang xac dinh card mang dang hoat dong (neu can)...
for /f "tokens=*" %%a in ('wmic nic where "NetConnectionStatus=2" get GUID /value ^| find "GUID"') do (
    set "NIC_GUID=%%a"
    set "NIC_GUID=!NIC_GUID:GUID=!"
    set "NIC_GUID=!NIC_GUID:{=!"
    set "NIC_GUID=!NIC_GUID:}=!"
)

:: =================================================================
:: BUOC 1: XOA CAC QUY TAC TUONG LUA DA TAO
:: =================================================================
echo.
echo [*] Go bo cac quy tac Firewall an minh...
netsh advfirewall firewall delete rule name="[Stealth+] Block Inbound ICMPv4" >nul
netsh advfirewall firewall delete rule name="[Stealth+] Block NetBIOS" >nul
netsh advfirewall firewall delete rule name="[Stealth+] Block LLMNR" >nul
netsh advfirewall firewall delete rule name="[Stealth+] Block mDNS" >nul
netsh advfirewall firewall delete rule name="[Stealth+] Block SMB" >nul
netsh advfirewall firewall delete rule name="[Stealth+] Block RDP" >nul
:: Xoa cac quy tac bo sung moi
netsh advfirewall firewall delete rule name="[Stealth+] Block RPC-EPMAP" >nul
netsh advfirewall firewall delete rule name="[Stealth+] Block NetBIOS-SSN" >nul
netsh advfirewall firewall delete rule name="[Stealth+] Block Unknown-Service" >nul


:: =================================================================
:: BUOC 2: KICH HOAT LAI CAC DICH VU HE THONG
:: =================================================================
echo.
echo [*] Khoi phuc cac dich vu he thong ve mac dinh...
sc config SSDPSRV start= delayed-auto >nul & sc start SSDPSRV >nul 2>&1
sc config upnphost start= demand >nul 2>&1
sc config FDResPub start= delayed-auto >nul & sc start FDResPub >nul 2>&1
sc config LanmanServer start= auto >nul & sc start LanmanServer >nul 2>&1
sc config RemoteRegistry start= auto >nul & sc start RemoteRegistry >nul 2>&1
sc config WinRM start= auto >nul & sc start WinRM >nul 2>&1
sc config TermService start= demand >nul 2>&1

:: =================================================================
:: BUOC 3: KHOI PHUC CAU HINH REGISTRY VA MANG
:: =================================================================
echo.
echo [*] Khoi phuc cac cau hinh trong Registry...

:: Khoi phuc dang ky hostname voi DHCP
if defined NIC_GUID (
    echo    - Khoi phuc dang ky Hostname voi DHCP...
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\!NIC_GUID!" /v RegisterAdapterName /f >nul
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v RegisterName /f >nul
) else (
    echo    - [LUU Y] Khong tim thay GUID cua card mang, bo qua buoc khoi phuc DHCP.
)

:: Khoi phuc TTL ve mac dinh cua Windows
echo    - Khoi phuc TTL mac dinh (128)...
netsh int ipv4 set global defaultcurhoplimit=128 >nul

echo.
echo =================================================================
echo [*] HOAN TAT! Cau hinh mang da duoc khoi phuc ve mac dinh.
echo [*] De dam bao moi thay doi co hieu luc, vui long KHOI DONG LAI may tinh.
echo =================================================================
pause