Function Remove-GuacUserGroup()
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
            Mandatory = $True
        )]
        [System.String]
        $Group

    )

    begin
    {
        $Uri = "$Server/api/session/data/$($DataSource)/userGroups/$Group/?token=$($Token)"
    }
    process
    {

        try
        {
            $RestCall = Invoke-RestMethod -Method DELETE -Uri $Uri -ContentType 'application/json' -Body $Body
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

#Remove-GuacUserGroup -DataSource mysql -Group "Parent"


