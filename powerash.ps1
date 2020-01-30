Add-Content -Path $PsHome\profile.ps1 -Value '$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")'
Add-Content -Path $PsHome\profile.ps1 -Value 'Remove-Item alias:curl'
