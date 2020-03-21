Function Get-GuacTunnel()
{
    param(


        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 1,
            Mandatory = $true
        )]
        [System.String]
        $TunnelId
    )

    begin
    {
        $Uri = "$Server/api/session/tunnels/$($TunnelId)/activeConnection/connection/sharingProfiles/?token=$($Token)"

    }
    process
    {

        try
        {
            $RestCall = Invoke-RestMethod -Method GET -Uri $Uri -ContentType 'application/json' -Body $Body
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

#Get-GuacTunnel -TunnelId 5
