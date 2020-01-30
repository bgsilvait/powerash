Function is_elevated{
    If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-warning "This script requires elevated privileges to change Install Windows Features and change files."
        Write-Host "Please re-launch the Powershell Session as Administrator." -foreground "red" -background "black"
        break
    }
}

Function choco{
    try {
        Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        #Force refresh env vars at all new powershell sessions for all users.
        Add-Content -Path $PsHome\profile.ps1 -Value '$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")'
        Add-Content -Path $PsHome\profile.ps1 -Value 'Remove-Item alias:curl' -erroraction 'ignore'
        Add-Content -Path $PsHome\profile.ps1 -Value 'new-alias grep findstr' -erroraction 'ignore'
        choco install vim curl awscli -y
    }
    catch {
        Write-Error "fail to install chocolatey"
        break
    }
}

is_elevated
choco
