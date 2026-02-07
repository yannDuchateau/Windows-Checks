Get-PhysicalDisk | Get-StorageReliabilityCounter | Select-Object -Property DeviceID, FriendlyName, Wear, Temperature, TemperatureMax | FT
winsat disk
winsat disk -ran -write -drive c