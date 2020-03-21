Function Get-GuacConnectionsHistory()
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
            Mandatory = $False
        )]
        [System.String]
        $Contains,

        [ValidateSet("startDate","endDate","remoteHost","username","active","connectionName",ignorecase=$true)]
        [Parameter(
            Position = 1,
            Mandatory = $False
        )]
        [System.String]
        $Order
    )

    begin
    {
        $Uri = "$Server/api/session/data/$($DataSource)/history/connections/?token=$($Token)"
        if ($Contains)
        {
            $Uri = "$Uri&contains=$($Contains)"
        }

        if ($Order)
        {
            $Uri = "$Uri&order=$($Order)"
        }
        Write-Output $Uri
    }
    process
    {

        try
        {
            $RestCall = Invoke-RestMethod -Method GET -Uri $Uri -ContentType 'application/json'
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

#Get-GuacConnectionsHistory -DataSource mysql -Contains "cms.cabinet02@fontenay-aux-roses.fr"
