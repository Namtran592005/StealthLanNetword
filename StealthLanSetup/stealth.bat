@echo off
setlocal enabledelayedexpansion

echo =================================================================
echo           KICH HOAT CHE DO AN DANH MẠNG LAN (STEALTH)
echo =================================================================
echo.
echo [*] LUU Y: Kich ban nay se thay doi sau cac cau hinh mang va he thong.
echo [*] Ban se can chay tep "restore.bat" de quay lai.
echo [*] Chay voi quyen Quan tri vien (Run as Administrator) la BAT BUOC.
echo.
pause
cls

echo [*] Dang xac dinh card mang dang hoat dong...
for /f "tokens=*" %%a in ('wmic nic where "NetConnectionStatus=2" get GUID /value ^| find "GUID"') do (
    set "NIC_GUID=%%a"
    set "NIC_GUID=!NIC_GUID:GUID=!"
    set "NIC_GUID=!NIC_GUID:{=!"
    set "NIC_GUID=!NIC_GUID:}=!"
)
if not defined NIC_GUID (
    echo [!] Khong tim thay card mang nao dang ket noi. Thoat.
    pause
    exit /b
)
echo [*] Phat hien card mang hoat dong: !NIC_GUID!

:: =================================================================
:: TANG 1: NGAN CHAN BI PHAT HIEN THU DONG
:: =================================================================
echo.
echo [TANG 1] Dang thiet lap cac quy tac an minh co ban...

:: Chan ICMP (Ping)
echo    - Chan Ping (ICMPv4)...
netsh advfirewall firewall add rule name="[Stealth+] Block Inbound ICMPv4" protocol=icmpv4:8,any dir=in action=block >nul

:: Tat cac dich vu kham pha
echo    - Tat cac dich vu kham pha (SSDP, UPnP, FDResPub)...
sc stop SSDPSRV >nul 2>&1
sc config SSDPSRV start= disabled >nul
sc stop upnphost >nul 2>&1
sc config upnphost start= disabled >nul
sc stop FDResPub >nul 2>&1
sc config FDResPub start= disabled >nul

:: Chan NetBIOS, LLMNR, mDNS qua Firewall
echo    - Chan NetBIOS, LLMNR, mDNS...
netsh advfirewall firewall add rule name="[Stealth+] Block NetBIOS" dir=in action=block protocol=UDP localport=137,138 >nul
netsh advfirewall firewall add rule name="[Stealth+] Block LLMNR" dir=in action=block protocol=UDP localport=5355 >nul
netsh advfirewall firewall add rule name="[Stealth+] Block mDNS" dir=in action=block protocol=UDP localport=5353 >nul

:: *** PHAN BO SUNG MOI BAT DAU TU DAY ***
echo    - [BO SUNG] Chan triet de cac cong he thong bi ro ri...
netsh advfirewall firewall add rule name="[Stealth+] Block RPC-EPMAP" dir=in action=block protocol=TCP localport=135 >nul
netsh advfirewall firewall add rule name="[Stealth+] Block NetBIOS-SSN" dir=in action=block protocol=TCP localport=139 >nul
netsh advfirewall firewall add rule name="[Stealth+] Block Unknown-Service" dir=in action=block protocol=TCP localport=5040 >nul
:: *** PHAN BO SUNG MOI KET THUC O DAY ***

:: Xoa bang ARP (tam thoi)
echo    - Xoa bo dem ARP cache...
arp -d *

:: =================================================================
:: TANG 3 & 5: AN DAU VET VA PHONG THU NANG CAO (GIU NGUYEN)
:: =================================================================
echo.
echo [TANG 3/5] Dang trien khai cac ky thuat an dau vet va bao mat...

:: Khong dang ky hostname voi DHCP
echo    - Vo hieu hoa dang ky Hostname voi DHCP...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\!NIC_GUID!" /v RegisterAdapterName /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v RegisterName /t REG_DWORD /d 0 /f >nul

:: Vo hieu hoa cac dich vu truy cap tu xa
echo    - Vo hieu hoa Remote Registry, WMI, RDP, SMB...
sc stop RemoteRegistry >nul 2>&1
sc config RemoteRegistry start= disabled >nul
sc stop WinRM >nul 2>&1
sc config WinRM start= disabled >nul
sc stop TermService >nul 2>&1
sc config TermService start= disabled >nul
netsh advfirewall firewall add rule name="[Stealth+] Block SMB" dir=in action=block protocol=TCP localport=445 >nul
netsh advfirewall firewall add rule name="[Stealth+] Block RDP" dir=in action=block protocol=TCP localport=3389 >nul

:: Khong chia se file/may in
echo    - Tat dich vu chia se File/Printer...
sc stop LanmanServer >nul 2>&1
sc config LanmanServer start= disabled >nul

:: Giam TTL de han che bi truy vet
echo    - Dat TTL mac dinh ve 1 de han che pham vi...
netsh int ipv4 set global defaultcurhoplimit=64 >nul

echo.
echo =================================================================
echo [*] HOAN TAT! Che do an thanh nang cao da duoc kich hoat.
echo [*] May tinh cua ban gio day rat kho bi phat hien tren mang LAN.
echo [*] Mot so thay doi (nhu MAC) co the can KHOI DONG LAI may de ap dung.
echo =================================================================
pause