@echo off
echo WARNING: This will remove all UWP apps, including the store, but "Settings" and "Windows Defender" is kept.
echo You also need to run this script as admin.
timeout /t 60 /nobreak
echo Deleting UWP apps . . . 
powershell "get-appxpackage | remove-appxpackage"
echo yes | reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SilentInstalledAppsEnabled /t REG_DWORD /d 0
taskkill /F /im SearchUI.exe
taskkill /F /im RemindersServer.exe
ren C:\Windows\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy Microsoft.Windows.Cortana_cw5n1h2txyewy.bak
echo Stopping Windows Updates . . . 
powershell "Set-Service -Name 'wuauserv' -Status stopped -StartupType disabled"
powershell "Set-Service -Name 'bits' -Status stopped -StartupType disabled"
powershell "Set-Service -Name 'dosvc' -Status stopped -StartupType disabled"
color a
cls
echo Done. 
pause
echo Rebooting now.
timeout /t 3
shutdown /t 00 /r