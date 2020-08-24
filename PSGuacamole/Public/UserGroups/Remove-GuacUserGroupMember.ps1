Function Remove-GuacUserGroupMember()
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
        $Member,

        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 2,
            Mandatory = $true
        )]
        [System.String]
        $Group
    )

    begin
    {
        $Parameters = @{
            "op"= "remove"
            "path"= "/"
            "value"= "$($Member)"
        } | ConvertTo-Json
        $Body   = "[$($Parameters)]"
        $Uri    = "$Server/api/session/data/$($DataSource)/userGroups/$Group/memberUsers/?token=$($Token)"
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
Remove-GuacUserGroupMember -DataSource mysql -Member "john.doe" -Group "test"
#>
