# APIConnection 

 - [New-GuacToken](#new-guactoken)
 - [Remove-GuacToken](#remove-guactoken)

## New-GuacToken
```Powershell
New-GuacToken -Username guacadmin -Password guacadmin -Server "http://srv-guacamole:8080/guacamole" -TOTP 803505
```
## Remove-GuacToken
```Powershell
Remove-GuacToken -Token $TokenToRemove -Server "http://srv-guacamole:8080/guacamole"
```

