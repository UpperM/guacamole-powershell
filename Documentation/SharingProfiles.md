# SharingProfiles 

 - [Get-GuacSharingProfile](#get-guacsharingprofile)
 - [Get-GuacSharingProfiles](#get-guacsharingprofiles)
 - [New-GuacSharingProfile](#new-guacsharingprofile)
 - [Remove-GuacSharingProfile](#remove-guacsharingprofile)

## Get-GuacSharingProfile
```Powershell
Get-GuacSharingProfile -DataSource mysql -SharingProfileId 1
```
## Get-GuacSharingProfiles
```Powershell
Get-GuacSharingProfiles -DataSource mysql
```
## New-GuacSharingProfile
```Powershell
$Parameters = @{
    "primaryConnectionIdentifier"= "52"
    "name"= "NewSharingProfile"
    "parameters"= @{
      "read-only"= ""
    }
    "attributes"= @{}
}

New-GuacSharingProfile -DataSource mysql -Parameters $Parameters
```
## Remove-GuacSharingProfile
```Powershell
Remove-GuacSharingProfile -DataSource mysql -SharingProfileId 2
```

