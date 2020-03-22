Function Stop-GuacConnection()
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
        $Identifier
    )

    begin
    {
        $Body = @{
            "op"="remove"
            "path"="/$($Identifier)"
        } | ConvertTo-Json
        $Body = "[$($Body)]"
        $Uri = "$Server/api/session/data/$($DataSource)/activeConnections?token=$($Token)"
    }
    process
    {
        try
        {
            $RestCall = Invoke-RestMethod -Method PATCH -Uri $Uri -ContentType 'application/json' -Body $Body
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
Stop-GuacConnection -DataSource mysql -Identifier "0a33d486-9947-4b67-bc17-9e1f5180aece"
#>
