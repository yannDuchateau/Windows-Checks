(Get-AppxPackage Microsoft.DesktopAppInstaller).Version
Stop-Process -Name "WindowsPackageManagerServer"
winget upgrade Microsoft.AppInstaller --accept-source-agreements --accept-package-agreements --include-unknown >$env:PUBLIC\Desktop\Logs\UpgradeAppInstaller.txt
Start-Process -FilePath "WindowsPackageManagerServer.exe"
winget upgrade --all --accept-source-agreements --accept-package-agreements --include-unknown  >$env:PUBLIC\Desktop\Logs\PackagesUpdates.txt
