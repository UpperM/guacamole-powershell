Function Update-GuacConnectionGroup()
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
        $Parameters,

        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 3,
            Mandatory = $true
        )]
        [System.String]
        $ConnectionGroupId
    )

    begin
    {
        $Body = $Parameters | ConvertTo-Json

        $Uri = "$Server/api/session/data/$($DataSource)/connectionGroups/$($ConnectionGroupId)/?token=$($Token)"
    }
    process
    {

        try
        {
            Invoke-RestMethod -Method PUT -Uri $Uri -ContentType 'application/json' -Body $Body
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
$Parameters = @{
    "name"="Desktop"
    "identifier"="1"
    "parentIdentifier"="ROOT"
    "type"="BALANCING"
    "activeConnections"=0
    "attributes"=@{
        "max-connections"=""
        "max-connections-per-user"=""
        "enable-session-affinity"=""
    }
}

Update-GuacConnectionGroup -DataSource mysql -ConnectionGroupId 1 -Parameters $Parameters
#>
