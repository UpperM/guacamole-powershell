Function New-GuacConnectionGroup()
{
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

        $Uri = "$Server/api/session/data/$($DataSource)/connectionGroups/?token=$($Token)"
        Write-Output $Body
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


$Parameters = @{
    "name"="New Group Name 2"
    "parentIdentifier"="1"
    "type"="BALANCING"
    "attributes"=@{
        "max-connections"=""
        "max-connections-per-user"=""
        "enable-session-affinity"=""
    }
}

#New-GuacConnectionGroup -DataSource mysql -Parameters $Parameters


