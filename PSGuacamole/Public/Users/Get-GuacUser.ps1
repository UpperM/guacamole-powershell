Function Get-GuacUser()
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
            Position = 3,
            Mandatory = $true
        )]
        [System.String]
        $Username,

        [ValidateSet("history","userGroups","effectivePermissions","permissions",ignorecase=$true)]
        [Parameter(
            Position = 3,
            Mandatory = $False
        )]
        [System.String]
        $Details

    )

    begin
    {
        $Uri = "$Server/api/session/data/$($DataSource)/users/$($Username)"

        if ($Details)
        {
            $Uri = "$Uri/$Details"
        }

        $Uri = "$Uri/?token=$($Token)"
    }
    process
    {
        try
        {
            $RestCall = Invoke-RestMethod -Method GET -Uri $Uri -ContentType 'application/json' -Body $Body
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
Get-GuacUser -DataSource mysql -Username "guacadmin" -Details permissions
#>
