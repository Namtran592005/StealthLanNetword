
@echo off
REM Create scheduled task to run arp_stealth.exe silently at login

set EXE_PATH=%%~dp0arp_stealth.exe

schtasks /create /f /tn "ARP Stealth Filter" /tr "%EXE_PATH%" /sc onlogon /rl highest /ru SYSTEM /np
echo.
echo [✓] Task created successfully! This machine will now ignore ARP requests from all devices except the router.
pause
