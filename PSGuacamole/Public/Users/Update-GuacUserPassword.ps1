Function Update-GuacUserPassword()
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
        [System.String]
        $OldPassword,

        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 2,
            Mandatory = $true
        )]
        [System.String]
        $NewPassword
    )

    begin
    {
        $Body = @{
            "oldPassword"= "$($OldPassword)"
            "newPassword"= "$($NewPassword)"
        } | ConvertTo-Json

        $Uri = "$Server/api/session/data/$($DataSource)/users/$Username/password?token=$($Token)"

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

<#
Update-GuacUserPassword -DataSource mysql -NewPassword "NewPass" -Username "john.doe" -OldPassword "OldPass"
#>
