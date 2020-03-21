Function Get-GuacTunnels()
{
    begin
    {
        $Uri = "$Server/api/session/tunnels/?token=$($Token)"
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

#Get-GuacTunnels
