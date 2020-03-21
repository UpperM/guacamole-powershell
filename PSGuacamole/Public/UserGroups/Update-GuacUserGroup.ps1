Function Update-GuacUserGroup()
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
        $Parameters,

        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 1,
            Mandatory = $true
        )]
        [System.String]
        $Group


    )

    begin
    {
        $Body = $Parameters | ConvertTo-Json
        $Uri = "$Server/api/session/data/$($DataSource)/userGroups/$($Group)/?token=$($Token)"
    }
    process
    {

        try
        {
            $RestCall = Invoke-RestMethod -Method PUT -Uri $Uri -ContentType 'application/json' -Body $Body
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

$Parameters = @{
    "identifier"= "test"
    "attributes"= @{
      "disabled"= "true"
    }
}

#Update-GuacUserGroup -DataSource mysql -Parameters $Parameters -Group "test"


