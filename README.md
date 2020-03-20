# PowerShell GuacAPI

[![GitHub release](https://img.shields.io/badge/release-v1.0.0-blue)](https://github.com/Sam-Martin/servicenow-powershell/releases/latest)

This PowerShell module provides a series of cmdlets for interacting with the [Apache Guacamole API](https://guacamole.apache.org/), performed by wrapping `Invoke-WebRequest` for the API calls.

## Requirements

Requires PowerShell 3.0 or above as this is when `Invoke-WebRequest` was introduced.

## Usage

Download the [latest release](https://github.com/UpperM/guacamole-powershell/releases/latest) and  extract the folder. Dot source the `Invoke-GuacAPI.ps1` to load functions.

```PowerShell
Set-Location -Path "C:\guacamole-powershell"
. .\Invoke-GuacAPI.ps1
```
Once you've done this, all the cmdlets will be at your disposal.

## API Authentification
#### Get new token
```PowerShell
New-GuacToken -Username "admin" -Password "MyPassword" -Server "http://srv-guacamole:8080/guacamole"
```
## User Management
#### Create a new user
```PowerShell
New-GuacUser -Username "john.doe" -Password "MyPassword" -DataSource "mysql"
```
#### Retrieve user
```PowerShell
Get-GuacUser -Username "john.doe" -DataSource "mysql"
```
#### Remove User
```PowerShell
Remove-GuacUser -Username "john.doe" -DataSource "mysql"
```

## Connections Management
### Retrieving all computers
```PowerShell
Get-GuacComputers -DataSource "mysql"
```

#### Retrieving a computer
```PowerShell
Get-GuacComputer -Computer "COMPUTER-001" -DataSource "mysql"
```

#### Create RDP connection
```PowerShell
New-GuacRdpComputer -Computer "COMPUTER-001" -Username "john.doe" -Password "MyPassword" -DataSource "mysql" -Security "nla"

```
#### Remove Computer
```PowerShell
Remove-GuacComputer -ComputerId 76 -DataSource "mysql"
```

#### Retrieving all connections groups
```PowerShell
Get-GuacConnectionGroups -DataSource "mysql"
```

#### Retrieving all connections groups
```PowerShell
Add-GuacUserPermissions -Username "john.doe" -ComputerId 76 -Permission "READ" -DataSource "mysql"
```

#### Retrieving all active connections
```PowerShell
Get-GuacActiveConnections -DataSource "mysql"
```
## Functions

* Add-GuacUserPermissions
* Get-GuacUser
* Get-GuacComputers
* Get-GuacComputer
* Get-GuacConnectionGroups
* Get-GuacActiveConnections
* New-GuacToken
* New-GuacUser
* New-RestCall
* New-GuacRdpComputer
* Remove-GuacUser
* Remove-GuacCompter

## Scope & Contributing

This module has been created as an abstraction layer to suit my immediate requirements. Contributions are gratefully received however, so please feel free to submit a pull request with additional features or amendments.

## Author

Author:: UpperM

Readme based on https://github.com/Sam-Martin/servicenow-powershell
