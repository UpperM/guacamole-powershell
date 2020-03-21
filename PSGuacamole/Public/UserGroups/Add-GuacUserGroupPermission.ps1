Function Add-GuacUserGroupPermission()
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
        $Group,

        [ValidateSet("CREATE_USER","CREATE_USER_GROUP","CREATE_CONNECTION","CREATE_CONNECTION_GROUP","CREATE_SHARING_PROFILE","ADMINISTER","READ",ignorecase=$true)]
        [Parameter(
            Position = 2,
            Mandatory = $true
        )]
        [System.String]
        $Permission
    )

    begin
    {
        $Path = "/systemPermissions"

        if ($Permission -eq "READ")
        {
            $Path = "/connectionPermissions/$($Group)"
        }

        $Body = @{
            "op"= "add"
            "path"= "$($Path)"
            "value"= "$($Permission)"
        } | ConvertTo-Json

        $Body = "[$($Body)]"

        $Uri = "$Server/api/session/data/$($DataSource)/userGroups/$Group/permissions?token=$($Token)"

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

#Add-GuacUserGroupPermission -DataSource mysql -Group "test" -Permission "READ"
