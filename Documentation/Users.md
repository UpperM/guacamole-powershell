# Users 

 - [Add-GuacUserConnection](#add-guacuserconnection)
 - [Get-GuacUser](#get-guacuser)
 - [Get-GuacUsers](#get-guacusers)
 - [New-GuacUser](#new-guacuser)
 - [Remove-GuacUser](#remove-guacuser)
 - [Remove-GuacUserConnection](#remove-guacuserconnection)
 - [Update-GuacUser](#update-guacuser)
 - [Update-GuacUserPassword](#update-guacuserpassword)

## Add-GuacUserConnection
```Powershell
Add-GuacUserConnection -DataSource mysql -ConnectionId 53 -Username "john.doe"
```
## Get-GuacUser
```Powershell
Get-GuacUser -DataSource mysql -Username "guacadmin" -Details permissions
```
## Get-GuacUsers
```Powershell
Get-GuacUser -DataSource mysql
```
## New-GuacUser
```Powershell
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
## Remove-GuacUser
```Powershell
Remove-GuacUser -DataSource mysql -Username "test"
```
## Remove-GuacUserConnection
```Powershell
Remove-GuacUserConnection -DataSource mysql -ConnectionId 53 -Username "john.doe"
```
## Update-GuacUser
```Powershell
$Username = "john.doe"
$Parameters = @{
    "username"= "$Username"
    "attributes"= @{
      "guac-email-address"= ""
      "guac-organizational-role"= ""
      "guac-full-name"= ""
      "expired"= ""
      "timezone"= ""
      "access-window-start"= ""
      "guac-organization"= ""
      "access-window-end"= ""
      "disabled"= ""
      "valid-until"= ""
      "valid-from"= ""
    }
}

Update-GuacUser -DataSource mysql -Username $Username -Parameters $Parameters
```
## Update-GuacUserPassword
```Powershell
Update-GuacUserPassword -DataSource mysql -NewPassword "NewPass" -Username "john.doe" -OldPassword "OldPass"
```

