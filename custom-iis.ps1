Function is_elevated{
    If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-warning "This script requires elevated privileges to change Install Windows Features and change files."
        Write-Host "Please re-launch the Powershell Session as Administrator." -foreground "red" -background "black"
        break
    }
}

Function iis{
    try {
Add-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter "system.webServer/httpProtocol/customHeaders" -Name "." "-AtElement @{name = "IP" ; value = $env:POD_IP}"
Add-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter "system.webServer/httpProtocol/customHeaders" -Name "." "-AtElement @{name = "ServiceAccount" ; value = $env:POD_SERVICE_ACCOUNT}"
Add-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter "system.webServer/httpProtocol/customHeaders" -Name "." "-AtElement @{name = "Namespace" ; value = $env:POD_NAMESPACE}"
Add-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter "system.webServer/httpProtocol/customHeaders" -Name "." "-AtElement @{name = "Node" ; value = $env:NODE_NAME}"
Add-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter "system.webServer/httpProtocol/customHeaders" -Name "." "-AtElement @{name = "Pod" ; value = $env:POD_NAME}"
Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.applicationHost/sites/siteDefaults/logFile/customFields" -name "." "-value @{logFieldName='X-Forwarded-For';sourceName='X-Forwarded-For';sourceType='RequestHeader'}"
        }
    catch {
        Write-Error "fail to iis custom"
        break
    }
}

is_elevated
iis
