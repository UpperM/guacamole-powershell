Function Remove-GuacSharingProfile()
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
        $SharingProfileId
    )

    begin
    {
        $Uri = "$Server/api/session/data/$($DataSource)/sharingProfiles/$($SharingProfileId)/?token=$($Token)"
    }
    process
    {
        try
        {
            Invoke-RestMethod -Method DELETE -Uri $Uri -ContentType 'application/json' -Body $Body
        }
        catch
        {
            throw $_.Exception.Message
            return $False
        }
    }
    end
    {
        return $True
    }
}

<#
Remove-GuacSharingProfile -DataSource mysql -SharingProfileId 2
#>
