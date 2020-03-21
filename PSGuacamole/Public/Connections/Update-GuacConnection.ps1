Function Update-GuacConnection()
{
    param(
        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 0,
            Mandatory = $true
        )]
        [System.String]
        $DataSource,



        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 2,
            Mandatory = $true
        )]
        [System.String]
        $ConnectionId,

        [Parameter(
            Position = 3,
            Mandatory = $True
        )]
        [System.Array]
        $Parameters

    )

    begin
    {
        $Body = $Parameters | ConvertTo-Json
        $Uri = "$Server/api/session/data/$($DataSource)/connections/$($ConnectionId)/?token=$($Token)"
    }
    process
    {

        try
        {
            $RestCall = Invoke-RestMethod -Method PUT -Uri $Uri -ContentType 'application/json' -Body $Body
        }
        catch
        {

            Write-Warning $_.Exception.Message
            return $False
        }

    }
    end
    {
        return $True
    }
}

$VNCParameters = @{
        "parentIdentifier"= "ROOT"
        "name"= "New VNC Connection"
        "protocol"= "vnc"
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
          "enable-sftp"= "true"
          "sftp-port"= ""
          "sftp-server-alive-interval"= ""
          "enable-audio"= ""
          "audio-servername"= ""
          "sftp-directory"= ""
          "sftp-root-directory"= ""
          "sftp-passphrase"= ""
          "sftp-private-key"= ""
          "sftp-username"= ""
          "sftp-password"= ""
          "sftp-host-key"= ""
          "sftp-hostname"= ""
          "recording-name"= ""
          "recording-path"= ""
          "dest-host"= ""
          "password"= ""
          "username"= ""
          "hostname"= ""
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

$SSHParameters = @{
    "parentIdentifier"= "ROOT"
    "name"= "New SSH Connection"
    "protocol"= "ssh"
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
      "timezone"= 'null'
      "server-alive-interval"= ""
      "backspace"= ""
      "terminal-type"= ""
      "create-typescript-path"= ""
      "hostname"= ""
      "host-key"= ""
      "private-key"= ""
      "username"= ""
      "password"= ""
      "passphrase"= ""
      "font-name"= ""
      "command"= ""
      "locale"= ""
      "typescript-path"= ""
      "typescript-name"= ""
      "recording-path"= ""
      "recording-name"= ""
      "sftp-root-directory"= ""
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

$KubernetesParameters = @{
    "parentIdentifier"= "ROOT"
    "name"= "New Kubernetes connection"
    "protocol"= "kubernetes"
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
      "use-ssl"= ""
      "ignore-cert"= ""
      "color-scheme"= ""
      "font-size"= ""
      "scrollback"= ""
      "backspace"= ""
      "create-typescript-path"= ""
      "hostname"= ""
      "ca-cert"= ""
      "namespace"= ""
      "pod"= ""
      "container"= ""
      "client-cert"= ""
      "client-key"= ""
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

#Update-GuacConnection -DataSource mysql -Parameters $TelnetParameters -ConnectionId 74
