Function New-GuacUserGroup()
{
    param(
        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 0,
            Mandatory = $true
        )]
        [System.String]
        $DataSource,



        [Parameter(
            Position = 2,
            Mandatory = $True
        )]
        [System.Array]
        $Parameters

    )

    begin
    {
        $Body = $Parameters | ConvertTo-Json
        $Uri = "$Server/api/session/data/$($DataSource)/userGroups/?token=$($Token)"
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

<#
$Parameters = @{
    "identifier"= "Parent"
    "attributes"= @{
      "disabled"= ""
    }
}
New-GuacUserGroup -DataSource mysql -Parameters $Parameters
#>
