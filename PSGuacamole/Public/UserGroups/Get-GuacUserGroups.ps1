Function Get-GuacUserGroups()
{
    param(
        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 0,
            Mandatory = $true
        )]
        [System.String]
        $DataSource
    )

    begin
    {
        $Uri = "$Server/api/session/data/$($DataSource)/userGroups/?token=$($Token)"
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
        return $RestCall.PsObject.Properties.Value
    }
}

#Get-GuacUserGroups -DataSource mysql
