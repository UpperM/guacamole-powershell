Function Add-GuacUserGroupMember()
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
            "op"= "add"
            "path"= "/"
            "value"= "$($Member)"
        } | ConvertTo-Json
        $Body   = "[$($Parameters)]"
        $Uri    = "$Server/api/session/data/$($DataSource)/userGroups/$Group/memberUsers/?token=$($Token)"
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

#Add-GuacUserGroupMember -DataSource mysql -Username "john.doe" -Member "test"
