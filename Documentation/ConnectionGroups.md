# ConnectionGroups 

 - [Get-GuacConnectionsGroup](#get-guacconnectionsgroup)
 - [Get-GuacConnectionsGroupDetails](#get-guacconnectionsgroupdetails)
 - [Get-GuacConnectionsGroups](#get-guacconnectionsgroups)
 - [Get-GuacConnectionsGroupsConnections](#get-guacconnectionsgroupsconnections)
 - [New-GuacConnectionGroup](#new-guacconnectiongroup)
 - [Remove-GuacConnectionGroup](#remove-guacconnectiongroup)
 - [Update-GuacConnectionGroup](#update-guacconnectiongroup)

## Get-GuacConnectionsGroup
```Powershell
Get-GuacConnectionsGroup -DataSource mysql -ConnectionGroupId 1 -Details $True
```
## Get-GuacConnectionsGroupDetails
```Powershell
Get-GuacConnectionsGroupDetails -DataSource mysql -ConnectionGroupId 2
```
## Get-GuacConnectionsGroups
```Powershell
Get-GuacConnectionsGroups -DataSource mysql
```
## Get-GuacConnectionsGroupsConnections
```Powershell
Get-GuacConnectionsGroupsConnections -DataSource mysql
```
## New-GuacConnectionGroup
```Powershell
$Parameters = @{
    "name"="New Group Name 2"
    "parentIdentifier"="1"
    "type"="BALANCING"
    "attributes"=@{
        "max-connections"=""
        "max-connections-per-user"=""
        "enable-session-affinity"=""
    }
}

New-GuacConnectionGroup -DataSource mysql -Parameters $Parameters
```
## Remove-GuacConnectionGroup
```Powershell
Remove-GuacConnectionGroup -DataSource mysql -ConnectionGroupId 3
```
## Update-GuacConnectionGroup
```Powershell
$Parameters = @{
    "name"="Desktop"
    "identifier"="1"
    "parentIdentifier"="ROOT"
    "type"="BALANCING"
    "activeConnections"=0
    "attributes"=@{
        "max-connections"=""
        "max-connections-per-user"=""
        "enable-session-affinity"=""
    }
}

Update-GuacConnectionGroup -DataSource mysql -ConnectionGroupId 1 -Parameters $Parameters
```

