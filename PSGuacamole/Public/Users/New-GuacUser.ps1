Function New-GuacUser()
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
        $Parameters
    )

    begin
    {
        $Body   = ConvertTo-Json -InputObject $Parameters
        $Uri    = "$Server/api/session/data/$($DataSource)/users/?token=$($Token)"
    }
    process
    {

        try
        {
            $RestCall = Invoke-RestMethod -Method POST -Uri $Uri -ContentType 'application/json' -Body $Body
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
    "username"= "test"
    "password"= "pass"
    "attributes"= @{
      "disabled"= ""
      "expired"= ""
      "access-window-start"= ""
      "access-window-end"= ""
      "valid-from"= ""
      "valid-until"= ""
      "timezone"= ""
      "guac-full-name"= ""
      "guac-organization"= ""
      "guac-organizational-role"= ""
    }
}

New-GuacUser -DataSource mysql -Parameters $Parameters
