Function Get-GuacConnection()
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
        $ConnectionId,

        [Parameter(
            Position = 4,
            Mandatory = $False
        )]
        [System.Boolean]
        $Details = $False,

        [Parameter(
            Position = 5,
            Mandatory = $False
        )]
        [System.Boolean]
        $History = $False
    )

    begin
    {
        $Uri = "$Server/api/session/data/$($DataSource)/connections/$($ConnectionId)"

        if ($Details -and !$History)
        {
            $Uri += "/parameters"
        }

        if ($History -and !$Details)
        {
            $Uri += "/history"
        }

        $Uri += "?token=$($Token)"
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

<#
Get-GuacConnection -DataSource mysql -ConnectionId 41 -Details $False -History $False
#>
