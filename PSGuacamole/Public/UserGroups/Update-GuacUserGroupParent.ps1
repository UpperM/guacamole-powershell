Function Update-GuacUserGroupParent()
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
        $Parent,

        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 2,
            Mandatory = $true
        )]
        [System.String]
        $Children
    )

    begin
    {
        $Parameters = @{
            "op"= "add"
            "path"= "/"
            "value"= "$($Children)"
        } | ConvertTo-Json

        $Body   = "[$($Parameters)]"
        $Uri    = "$Server/api/session/data/$($DataSource)/userGroups/$Parent/userGroups/?token=$($Token)"

        Write-Output $Uri
        Write-Output $Body
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

#Update-GuacUserGroupParent -DataSource mysql -Parent "Parent" -Children "test"
