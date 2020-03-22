Function Remove-GuacConnection()
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
        $ConnectionId

    )

    begin
    {
        $Uri = "$Server/api/session/data/$($DataSource)/connections/$($ConnectionId)/?token=$($Token)"
    }
    process
    {
        try
        {
            Invoke-RestMethod -Method DELETE -Uri $Uri -ContentType 'application/json' -Body $Body
        }
        catch
        {
            throw $_.Exception.Message
            return $False
        }
    }
    end
    {
        return $True
    }
}

<#
Remove-GuacConnection -DataSource mysql -ConnectionId 74
#>
