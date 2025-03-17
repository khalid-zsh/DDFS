@echo off
echo Enabling TeamViewer Black Screen...
powershell -Command "Start-Process 'cmd.exe' -ArgumentList '/c REG ADD \"HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\TeamViewer\" /v \"EnableBlackScreen\" /t REG_DWORD /d 1 /f' -Verb runAs"
taskkill /IM TeamViewer.exe /F
start "" "C:\Program Files (x86)\TeamViewer\TeamViewer.exe"
exit
