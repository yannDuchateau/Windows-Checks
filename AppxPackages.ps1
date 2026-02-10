Import-Module Appx
Import-Module Dism
Get-AppxPackage -AllUsers | Where PublisherId -eq 8wekyb3d8bbwe | Format-List -Property PackageFullName,PackageUserInformation >$env:PUBLIC\Desktop\Logs\InstalledMSPackages.txt
DISM /online /get-packages >>$env:PUBLIC\Desktop\Logs\LocalAvailablePackages.txt

Invoke-Item $env:PUBLIC\Desktop\Logs\InstalledMSPackages.txt
Invoke-Item $env:PUBLIC\Desktop\Logs\LocalAvailablePackages.txt