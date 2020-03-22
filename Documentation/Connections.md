# Connections 

 - [Get-GuacActiveConnections](#get-guacactiveconnections)
 - [Get-GuacConnection](#get-guacconnection)
 - [Get-GuacConnections](#get-guacconnections)
 - [New-GuacConnection](#new-guacconnection)
 - [Remove-GuacConnection](#remove-guacconnection)
 - [Stop-GuacConnection](#stop-guacconnection)
 - [Update-GuacConnection](#update-guacconnection)

## Get-GuacActiveConnections
```Powershell
Get-GuacActiveConnections -DataSource mysql
```
## Get-GuacConnection
```Powershell
Get-GuacConnection -DataSource mysql -ConnectionId 41 -Details $False -History $False
```
## Get-GuacConnections
```Powershell
Get-GuacConnections -DataSource mysql
```
## New-GuacConnection
```Powershell
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
New-GuacConnection -DataSource mysql -Parameters $TelnetParameters
```
## Remove-GuacConnection
```Powershell
Remove-GuacConnection -DataSource mysql -ConnectionId 74
```
## Stop-GuacConnection
```Powershell
Stop-GuacConnection -DataSource mysql -Identifier "0a33d486-9947-4b67-bc17-9e1f5180aece"
```
## Update-GuacConnection
```Powershell
$TelnetParameters = @{
    "parentIdentifier"= "ROOT"
    "name"= "Update Telnet Connection"
    "protocol"= "telnet"
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
      "color-scheme"= ""
      "font-size"= ""
      "scrollback"= ""
      "backspace"= ""
      "terminal-type"= ""
      "create-typescript-path"= ""
      "hostname"= ""
      "username"= ""
      "password"= ""
      "username-regex"= ""
      "password-regex"= ""
      "login-success-regex"= ""
      "login-failure-regex"= ""
      "font-name"= ""
      "typescript-path"= ""
      "typescript-name"= ""
      "recording-path"= ""
      "recording-name"= ""
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

Update-GuacConnection -DataSource mysql -Parameters $TelnetParameters -ConnectionId 74
```

