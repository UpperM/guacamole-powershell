Function Get-GuacSharingProfile()
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
        $SharingProfileId

    )

    begin
    {
        $Uri = "$Server/api/session/data/$($DataSource)/sharingProfiles/$($SharingProfileId)?token=$($Token)"
    }
    process
    {
        try
        {
            $RestCall = Invoke-RestMethod -Method GET -Uri $Uri -ContentType 'application/json'
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
Get-GuacSharingProfile -DataSource mysql -SharingProfileId 1
#>
