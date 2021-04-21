# Permissions 

 - [Add-GuacConnectionGroupMember](#add-guacconnectiongroupmember)
 - [Add-GuacSystemPermission](#add-guacsystempermission)
 - [Add-GuacUserPermission](#add-guacuserpermission)
 - [Remove-GuacConnectionGroupMember](#remove-guacconnectiongroupmember)
 - [Remove-GuacSystemPermission](#remove-guacsystempermission)
 - [Remove-GuacUserPermission](#remove-guacuserpermission)

## Add-GuacConnectionGroupMember
```Powershell
Add-GuacConnectionGroupMember -DataSource mysql -Username "john.doe" -Permission "READ" -ConnectionGroupId 1
```
## Add-GuacSystemPermission
```Powershell
Add-GuacSystemPermission -DataSource mysql -Username "john.doe" -Permission "ADMINISTER"
```
## Add-GuacUserPermission
```Powershell
Add-GuacUserPermission -DataSource mysql -Username "john.doe" -Permission "UPDATE"
```
## Remove-GuacConnectionGroupMember
```Powershell
Remove-GuacConnectionGroupMember -DataSource mysql -Username "john.doe" -Permission "READ" -ConnectionGroupId 1
```
## Remove-GuacSystemPermission
```Powershell
Remove-GuacSystemPermission -DataSource mysql -Username "john.doe" -Permission "ADMINISTER"
```
## Remove-GuacUserPermission
```Powershell
Remove-GuacUserPermission -DataSource mysql -Username "john.doe" -Permission "UPDATE"
```

