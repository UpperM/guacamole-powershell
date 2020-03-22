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
            Position = 1,
            Mandatory = $true
        )]
        [System.String]
        $ConnectionId,

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
<#
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
#>
