'Saving the Windows Services Startup Settings in a .REG File.

Const HKEY_LOCAL_MACHINE = &H80000002
Dim intServiceType, intStartupType, strDisplayName
Set WshShell = CreateObject("Wscript.Shell")
Set objFSO = Wscript.CreateObject("Scripting.FilesystemObject")
strNow = Month(Date) & Day(Date) & Year(Date)
strBackupFile = WshShell.SpecialFolders("Desktop") & "\Services_Backup_" & strNow & ".REG"
Set b = objFSO.CreateTextFile (strBackupFile, True)
b.WriteLine "Windows Registry Editor Version 5.00"
b.WriteBlankLines 1
b.WriteLine "Services Startup Configuration Backup" & Now
b.WriteBlankLines 1
strComputer = "."
Set objReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & _
    strComputer & "\root\default:StdRegProv")
strKeyPath = "SYSTEM\CurrentControlSet\Services"
objReg.EnumKey HKEY_LOCAL_MACHINE, strKeyPath, arrSubKeys
For Each subkey In arrSubKeys
    If IsWin32Service ("HKLM\" & strKeyPath & "\" & subkey) Then
        b.WriteLine "[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\" & subkey & "]"
        If strDisplayName <> "" Then
            b.WriteLine chr(34) & "DisplayName" & Chr(34) & _
                "=" & Chr(34) & strDisplayName & Chr(34)
        End If

        b.WriteLine chr(34) & "Start" & Chr(34) & "=dword:" & intStartupType
        b.WriteBlankLines 1
    End If
Next

Function IsWin32Service(sValue)
    IsWin32Service = False
    intServiceType = 0
    strDisplayName = ""
      intStartupType = 4
      On Error Resume Next
      intServiceType = WshShell.RegRead(sValue & "\type")
      On Error Goto 0
      If intServiceType = 16 Or intServiceType = 32 Or intServiceType = 256 Then
          IsWin32Service = True
        On Error Resume Next
          strDisplayName = Trim(WshShell.RegRead(sValue & "\Displayname"))
          intStartupType = Trim(WshShell.RegRead(sValue & "\Start"))
          intStartupType = "0000000" & intStartupType
          On Error Goto 0
       End If
End Function

b.Close
WshShell.Run "Notepad " & strBackupFile
Set objFSO = Nothing
Set WshShell = Nothing