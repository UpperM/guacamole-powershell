Function New-GuacConnection()
{
  <#
    .EXAMPLE
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
  #>

  param(
        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 0,
            Mandatory = $true
        )]
        [System.String]
        $DataSource,



        [Parameter(
            Position = 2,
            Mandatory = $True
        )]
        [System.Array]
        $Parameters

    )



    begin
    {
        $Body = $Parameters | ConvertTo-Json
        $Uri = "$Server/api/session/data/$($DataSource)/connections/?token=$($Token)"
    }
    process
    {

        try
        {
            $RestCall = Invoke-RestMethod -Method POST -Uri $Uri -ContentType 'application/json' -Body $Body
        }
        catch
        {

            Write-Warning $_.Exception.Message
            return $False
        }

    }
    end
    {
        return $RestCall
    }
}
