Function Add-GuacSystemPermission()
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
            Position = 2,
            Mandatory = $true
        )]
        [System.String]

        $Username,
        [ValidateSet("CREATE_USER","CREATE_USER_GROUP","CREATE_CONNECTION","CREATE_CONNECTION_GROUP","CREATE_SHARING_PROFILE","ADMINISTER",ignorecase=$true)]
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
          "op"= "add"
          "path"= "/systemPermissions"
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
Add-GuacSystemPermission -DataSource mysql -Username "john.doe" -Permission "ADMINISTER"
#>
