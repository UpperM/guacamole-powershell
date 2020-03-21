Function Get-GuacConnectionsGroup()
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
            Position = 3,
            Mandatory = $true
        )]
        [System.String]
        $ConnectionGroupId,

        [Parameter(
            Position = 4,
            Mandatory = $False
        )]
        [System.Boolean]
        $Details = $False


    )

    begin
    {
        $Uri = "$Server/api/session/data/$($DataSource)/connectionGroups/$($ConnectionGroupId)"

        if ($Details)
        {
            $Uri += "/tree"
        }

        $Uri += "/?token=$($Token)"
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

#Get-GuacConnectionsGroup -DataSource mysql -ConnectionGroupId 1 -Details $True
