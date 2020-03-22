Function New-GuacSharingProfile()
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
        $Parameters
    )

    begin
    {
        $Body = ConvertTo-Json -InputObject $Parameters
        $Uri = "$Server/api/session/data/$($DataSource)/sharingProfiles/?token=$($Token)"
    }
    process
    {
        try
        {
            $RestCall = Invoke-RestMethod -Method POST -Uri $Uri -ContentType 'application/json' -Body $Body -Verbose
        }
        catch
        {
            Write-Warning $_
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
    "primaryConnectionIdentifier"= "52"
    "name"= "NewSharingProfile"
    "parameters"= @{
      "read-only"= ""
    }
    "attributes"= @{}
}

New-GuacSharingProfile -DataSource mysql -Parameters $Parameters
#>
