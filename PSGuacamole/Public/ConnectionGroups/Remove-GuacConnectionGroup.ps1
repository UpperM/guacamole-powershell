Function Remove-GuacConnectionGroup()
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
        $ConnectionGroupId

    )

    begin
    {
        $Uri = "$Server/api/session/data/$($DataSource)/connectionGroups/$($ConnectionGroupId)/?token=$($Token)"
    }
    process
    {

        try
        {
            Invoke-RestMethod -Method DELETE -Uri $Uri -ContentType 'application/json'
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
Remove-GuacConnectionGroup -DataSource mysql -ConnectionGroupId 3
#>
