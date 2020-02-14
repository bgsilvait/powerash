# Powershell with popular Bash sintax and Chocolatey

## Introduction

**powerash** is a Powershell script that creates some aliases and install the Package Manager for Windows [chocolatey](https://chocolatey.org/). It can be used in **Windows Server** and **Windows Containers**

## Usage

### In a powershell session:

**Run this project as the Administrator user**
```
iwr -o powerash.ps1 https://raw.githubusercontent.com/bgsilvait/powerash/master/powerash.ps1
.\powerash.ps1
```

### For AWS EC2 Userdata:
```
<powershell>
iwr -o powerash.ps1 https://raw.githubusercontent.com/bgsilvait/powerash/master/powerash.ps1
.\powerash.ps1
&$PSHOME\profile.ps1
choco install vim curl awscli -y
</powershell>
```

## Examples

```
vim foo
curl -I foo.bar
aws s3 ls
cat foo | grep bar
```
