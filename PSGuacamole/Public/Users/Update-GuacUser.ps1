Function Update-GuacUser()
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
        $Uri    = "$Server/api/session/data/$($DataSource)/users/$Username/?token=$($Token)"

        Write-Output $Body

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

$Username = "john.doe"

$Parameters = @{
    "username"= "$Username"
    "attributes"= @{
      "guac-email-address"= ""
      "guac-organizational-role"= ""
      "guac-full-name"= ""
      "expired"= ""
      "timezone"= ""
      "access-window-start"= ""
      "guac-organization"= ""
      "access-window-end"= ""
      "disabled"= ""
      "valid-until"= ""
      "valid-from"= ""
    }
}

#Update-GuacUser -DataSource mysql -Username $Username -Parameters $Parameters
