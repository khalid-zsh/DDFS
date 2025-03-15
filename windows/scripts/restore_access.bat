@echo off
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f
taskkill /IM disable_keys.exe /F
exit
