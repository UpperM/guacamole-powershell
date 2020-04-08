Function Remove-GuacUserPermission()
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
        $Username,

        [ValidateSet("UPDATE",ignorecase=$true)]
        [Parameter(
            Position = 2,
            Mandatory = $true
        )]
        [System.String]
        $Permission
    )

    begin
    {
        $Body = @{
          "op"= "remove"
          "path"= "/userPermissions/$($Username)"
          "value"= "$($Permission)"
        } | ConvertTo-Json

        $Body = "[$($Body)]"
        $Uri = "$Server/api/session/data/$($DataSource)/users/$Username/permissions?token=$($Token)"
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
Remove-GuacUserPermission -DataSource mysql -Username "john.doe" -Permission "UPDATE"
#>
