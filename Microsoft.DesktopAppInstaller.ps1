# Restore/Repair/update the Store. when WinGet is down.
Invoke-webrequest https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile C:\Sources\addons\appx\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
Stop-Process -Name "WindowsPackageManagerServer"
Add-ProvisionedAppPackage -online -PackagePath "C:\Sources\addons\appx\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -skiplicense
Add-AppxPackage -Path "C:\Sources\addons\appx\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
Start-Process -FilePath "WindowsPackageManagerServer.exe"