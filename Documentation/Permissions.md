# Permissions 

 - [Add-GuacConnectionGroupMember](#add-guacconnectiongroupmember)
 - [Add-GuacSystemPermission](#add-guacsystempermission)
 - [Remove-GuacConnectionGroupMember](#remove-guacconnectiongroupmember)
 - [Remove-GuacSystemPermission](#remove-guacsystempermission)
 - [Add-GuacUserPermission](#add-guacuserpermission)
 - [Remove-GuacUserPermission](#remove-guacuserpermission)
 
## Add-GuacConnectionGroupMember
```Powershell
Add-GuacConnectionGroupMember -DataSource mysql -Username "john.doe" -Permission "READ" -ConnectionGroupId 1
```
## Add-GuacSystemPermission
```Powershell
Add-GuacSystemPermission -DataSource mysql -Username "john.doe" -Permission "ADMINISTER"
```
## Remove-GuacConnectionGroupMember
```Powershell
Remove-GuacConnectionGroupMember -DataSource mysql -Username "john.doe" -Permission "READ" -ConnectionGroupId 1
```
## Remove-GuacSystemPermission
```Powershell
Remove-GuacSystemPermission -DataSource mysql -Username "john.doe" -Permission "ADMINISTER"
```
## Allow user to change own password
```Powershell
Add-GuacUserPermission -DataSource mysql -Username "john.doe" -Permission "UPDATE"
```
## Disallow user to change own password
```Powershell
Remove-GuacUserPermission -DataSource mysql -Username "john.doe" -Permission "UPDATE"
```