Function Get-GuacSchemaProtocols()
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
        $Uri = "$Server/api/session/data/$($DataSource)/schema/protocols/?token=$($Token)"

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

#Get-GuacSchemaConnectionProtocol -DataSource mysql
