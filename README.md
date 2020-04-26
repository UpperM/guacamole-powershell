# PSGuacamole
![alt text](https://raw.githubusercontent.com/UpperM/guacamole-powershell/master/PSGuacamole-logo.png)

[![GitHub release](https://img.shields.io/badge/release-v1.0.2-blue)](https://github.com/UpperM/guacamole-powershell/releases/latest)

This PowerShell module provides a series of cmdlets for interacting with the [Apache Guacamole API](https://guacamole.apache.org/), performed by wrapping `Invoke-RestMethod` for the API calls.


<!-- TABLE OF CONTENTS -->
## Table of Contents
* [Getting Started](#getting-started)
  * [Requirements](#requirements)
  * [Installation](#installation)
* [Examples](#examples)
  * [Authentification](#authentification)
  * [User Management](#user-management)
  * [Connections Management](#connections-management)
* [Functions](#functions)
  * [APIConnection](Documentation/APIConnection.md)
  * [ConnectionGroups](Documentation/ConnectionGroups.md)
  * [Connections](Documentation/Connections.md)
  * [History](Documentation/History.md)
  * [Languages](Documentation/Languages.md)
  * [Patch](Documentation/Patch.md)
  * [Permissions](Documentation/Permissions.md)
  * [Schemas](Documentation/Schemas.md)
  * [SharingProfiles](Documentation/SharingProfiles.md)
  * [Tunnels](Documentation/Tunnels.md)
  * [UserGroups](Documentation/UserGroups.md)
  * [Users](Documentation/Users.md)
* [Author](#author)

# Getting Started
## Requirements
Requires PowerShell 3.0 or above as this is when `Invoke-RestMethod` was introduced.

## Installation
Download the [latest release](https://github.com/UpperM/guacamole-powershell/releases/latest) and extract the folder to your module location (``$env:PSModulePath``).

Load the module
```PowerShell
Import-Module -Name PSGuacamole
```
Once you've done this, all the cmdlets will be at your disposal.

# Examples

## Authentification
#### Get new token
```PowerShell
New-GuacToken -Username "admin" -Password "MyPassword" -Server "http://srv-guacamole:8080/guacamole"
```

## User Management
#### Create a new user
```PowerShell
$Parameters = @{
    "username"= "test"
    "password"= "pass"
    "attributes"= @{
      "disabled"= ""
      "expired"= ""
      "access-window-start"= ""
      "access-window-end"= ""
      "valid-from"= ""
      "valid-until"= ""
      "timezone"= ""
      "guac-full-name"= ""
      "guac-organization"= ""
      "guac-organizational-role"= ""
    }
}

New-GuacUser -DataSource mysql -Parameters $Parameters
```

#### Retrieve user
```PowerShell
Get-GuacUser -Username "john.doe" -DataSource "mysql"
```
#### Retrieve user connection history
```PowerShell
Get-GuacUser -Username "john.doe" -DataSource "mysql" -Details history
```

#### Remove User
```PowerShell
Remove-GuacUser -Username "john.doe" -DataSource "mysql"
```

## Connections Management
### Retrieving all connections
```PowerShell
Get-GuacConnections -DataSource "mysql"
```

#### Retrieving a connection
```PowerShell
Get-GuacConnection -DataSource mysql -ConnectionId 41 -Details $False -History $False
```

#### Create RDP connection
```PowerShell
$RDPParameters = @{
        "parentIdentifier"= "ROOT"
        "name"= "New RDP Connection"
        "protocol"= "rdp"
        "parameters"= @{
          "port"= ""
          "read-only"= ""
          "swap-red-blue"= ""
          "cursor"= ""
          "color-depth"= ""
          "clipboard-encoding"= ""
          "disable-copy"= ""
          "disable-paste"= ""
          "dest-port"= ""
          "recording-exclude-output"= ""
          "recording-exclude-mouse"= ""
          "recording-include-keys"= ""
          "create-recording-path"= ""
          "enable-sftp"= ""
          "sftp-port"= ""
          "sftp-server-alive-interval"= ""
          "enable-audio"= ""
          "security"= ""
          "disable-auth"= ""
          "ignore-cert"= ""
          "gateway-port"= ""
          "server-layout"= ""
          "timezone"= ""
          "console"= ""
          "width"= ""
          "height"= ""
          "dpi"= ""
          "resize-method"= ""
          "console-audio"= ""
          "disable-audio"= ""
          "enable-audio-input"= ""
          "enable-printing"= ""
          "enable-drive"= ""
          "create-drive-path"= ""
          "enable-wallpaper"= ""
          "enable-theming"= ""
          "enable-font-smoothing"= ""
          "enable-full-window-drag"= ""
          "enable-desktop-composition"= ""
          "enable-menu-animations"= ""
          "disable-bitmap-caching"= ""
          "disable-offscreen-caching"= ""
          "disable-glyph-caching"= ""
          "preconnection-id"= ""
          "hostname"= ""
          "username"= ""
          "password"= ""
          "domain"= ""
          "gateway-hostname"= ""
          "gateway-username"= ""
          "gateway-password"= ""
          "gateway-domain"= ""
          "initial-program"= ""
          "client-name"= ""
          "printer-name"= ""
          "drive-name"= ""
          "drive-path"= ""
          "static-channels"= ""
          "remote-app"= ""
          "remote-app-dir"= ""
          "remote-app-args"= ""
          "preconnection-blob"= ""
          "load-balance-info"= ""
          "recording-path"= ""
          "recording-name"= ""
          "sftp-hostname"= ""
          "sftp-host-key"= ""
          "sftp-username"= ""
          "sftp-password"= ""
          "sftp-private-key"= ""
          "sftp-passphrase"= ""
          "sftp-root-directory"= ""
          "sftp-directory"= ""
        }
        "attributes"= @{
          "max-connections"= ""
          "max-connections-per-user"= ""
          "weight"= ""
          "failover-only"= ""
          "guacd-port"= ""
          "guacd-encryption"= ""
          "guacd-hostname"= ""
        }
    }
    New-GuacConnection -DataSource mysql -Parameters $RDPParameters
```
#### Remove a connection
```PowerShell
Remove-GuacConnection -DataSource mysql -ConnectionId 74
```

#### Retrieving all connections groups
```PowerShell
Get-GuacConnectionsGroups -DataSource mysql
```

#### Retrieving all active connections
```PowerShell
Get-GuacActiveConnections -DataSource mysql
```

# Functions
## ConnectionGroups
* Get-GuacConnectionsGroup
* Get-GuacConnectionsGroupDetails
* Get-GuacConnectionsGroups
* Get-GuacConnectionsGroupsConnections
* New-GuacConnectionGroup
* Remove-GuacConnectionGroup
* Update-GuacConnectionGroup
## Connections
* Get-GuacActiveConnections
* Get-GuacConnection
* Get-GuacConnections
* New-GuacConnection
* Remove-GuacConnection
* Stop-GuacConnection
* Update-GuacConnection
## History
* Get-GuacConnectionsHistory
* Get-GuacUsersHistory
## Languages
* Get-GuacLanguages
## Patch
* Get-GuacPatches
## Permissions
* Add-GuacConnectionGroupMember
* Add-GuacSystemPermission
* Remove-GuacConnectionGroupMember
* Remove-GuacSystemPermission
## Schemas
* Get-GuacSchemaConnection
* Get-GuacSchemaConnectionGroup
* Get-GuacSchemaProtocols
* Get-GuacSchemaSharingProfile
* Get-GuacSchemaUser
## SharingProfiles
* Get-GuacSharingProfile
* Get-GuacSharingProfiles
* New-GuacSharingProfile
* Remove-GuacSharingProfile
## Token
* New-GuacToken
* Remove-GuacToken
## Tunnels
* Get-GuacTunnel
* Get-GuacTunnels
## UserGroups
* Add-GuacUserGroupConnection
* Add-GuacUserGroupMember
* Add-GuacUserGroupPermission
* Get-GuacUserGroup
* Get-GuacUserGroups
* New-GuacUserGroup
* Remove-GuacUserGroup
* Remove-GuacUserGroupConnection
* Remove-GuacUserGroupPermission
* Update-GuacUserGroup
* Update-GuacUserGroupParent
## Users
* Add-GuacUserConnection
* Get-GuacUser
* Get-GuacUsers
* New-GuacUser
* Remove-GuacUser
* Remove-GuacUserConnection
* Update-GuacUser
* Update-GuacUserPassword

# Author
Author: [UpperM](https://twitter.com/UppperM)
