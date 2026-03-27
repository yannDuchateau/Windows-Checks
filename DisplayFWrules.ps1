<# 
.CREATED BY: 
    Yann C: Duchateau 
.CREATED ON: 
    103\08\2026 
.Synopsis 
   Automate Showinf Firewall Rules 
.DESCRIPTION 
   Displays all the registered firewall rules and their Status. ` 
   All deleted files will go into a log transcript in C:\Windows\Temp\. By default this ` 
   script leaves files that are newer than 7 days old however this variable can be edited. 
.EXAMPLE 
   PS C:\Users\Administrator\Desktop\Powershell> .\DisplayFWrules.ps1 
   Save the file to your desktop with a .PS1 extention and run the file from an elavated PowerShell prompt. 
.NOTES 
   This script will typically clean up anywhere from 1GB up to 15GB of space from a C: drive. 
.FUNCTIONALITY 
   PowerShell v3 
#> 
function global:Write-Verbose ( [string]$Message ) 
 
# check $VerbosePreference variable, and turns -Verbose on 
{ if ( $VerbosePreference -ne 'SilentlyContinue' ) 
{ Write-Host " $Message" -ForegroundColor 'Yellow' } } 
 
$VerbosePreference = "Continue" 
$DaysToDelete = 1 
$LogDate = get-date -format "MM-dd-yyyy-HH" 
$objShell = New-Object -ComObject Shell.Application 
$objFolder = $objShell.Namespace(0xA) 
$ErrorActionPreference = "silentlycontinue" 
 clear-host
Start-Transcript -Path C:\Temp\NetFirewallRule$LogDate.log 


$FWdisabled = Get-NetFirewallRule | Where-Object {$_.Enabled -Like "False" -and $_.PrimaryStatus -Like "Ok"} | Select Name,DisplayName,DisplayGroup,Profile,PackageFamilyName,Direction,Action,EdgeTraversalPolicy  | format-table -AutoSize | Out-String 

$FWenabled = Get-NetFirewallRule | Where-Object {$_.Enabled -Like "True"} | Select Name,Profile,PackageFamilyName,Direction,Action,EdgeTraversalPolicy  | format-table -AutoSize | Out-String 


Hostname ; Get-Date | Select-Object DateTime 
Write-Verbose "Activated Firewal rules: $FWenabled" 
Write-Verbose "Deactivated Firewal rules: $FWdisabled" 

## Completed Successfully! 
Stop-Transcript
#The command below will open the report to default browser
Get-ChildItem -Path C:\Temp\FWR$LogDate.log
Invoke-Item -Path C:\Temp\FWR$LogDate.log
Invoke-Item -Path C:\Temp\NetFirewallRule03-27-2026-10.03.log