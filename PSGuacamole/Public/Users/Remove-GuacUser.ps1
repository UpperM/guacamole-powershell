Function Remove-GuacUser()
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
        $Username
    )

    begin
    {
        $Uri    = "$Server/api/session/data/$($DataSource)/users/$($Username)/?token=$($Token)"
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

#Remove-GuacUser -DataSource mysql -Username "test"
