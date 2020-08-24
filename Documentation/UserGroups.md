# UserGroups 

 - [Add-GuacUserGroupConnection](#add-guacusergroupconnection)
 - [Add-GuacUserGroupMember](#add-guacusergroupmember)
 - [Add-GuacUserGroupPermission](#add-guacusergrouppermission)
 - [Get-GuacUserGroup](#get-guacusergroup)
 - [Get-GuacUserGroups](#get-guacusergroups)
 - [New-GuacUserGroup](#new-guacusergroup)
 - [Remove-GuacUserGroup](#remove-guacusergroup)
 - [Remove-GuacUserGroupConnection](#remove-guacusergroupconnection)
 - [Remove-GuacUserGroupPermission](#remove-guacusergrouppermission)
 - [Update-GuacUserGroup](#update-guacusergroup)
 - [Update-GuacUserGroupParent](#update-guacusergroupparent)

## Add-GuacUserGroupConnection
```Powershell
Add-GuacUserGroupConnection -DataSource mysql -ConnectionId 52 -Group "test"
```
## Add-GuacUserGroupMember
```Powershell
Add-GuacUserGroupMember -DataSource mysql -Member "john.doe" -Group "test"
```
## Add-GuacUserGroupPermission
```Powershell
Add-GuacUserGroupPermission -DataSource mysql -Group "test" -Permission "READ"
```
## Get-GuacUserGroup
```Powershell
Get-GuacUserGroup -DataSource mysql -Group test
```
## Get-GuacUserGroups
```Powershell
Get-GuacUserGroups -DataSource mysql
```
## New-GuacUserGroup
```Powershell
$Parameters = @{
    "identifier"= "Parent"
    "attributes"= @{
      "disabled"= ""
    }
}
New-GuacUserGroup -DataSource mysql -Parameters $Parameters
```
## Remove-GuacUserGroup
```Powershell
Remove-GuacUserGroup -DataSource mysql -Group "Parent"
```
## Remove-GuacUserGroupConnection
```Powershell
Remove-GuacUserGroupConnection -DataSource mysql -ConnectionId 52 -Group "test"
```
## Remove-GuacUserGroupPermission
```Powershell
Remove-GuacUserGroupPermission -DataSource mysql -Group "test" -Permission "ADMINISTER"
```
## Update-GuacUserGroup
```Powershell
$Parameters = @{
    "identifier"= "test"
    "attributes"= @{
      "disabled"= "true"
    }
}

Update-GuacUserGroup -DataSource mysql -Parameters $Parameters -Group "test"
```
## Update-GuacUserGroupParent
```Powershell
Update-GuacUserGroupParent -DataSource mysql -Parent "Parent" -Children "test"
```

