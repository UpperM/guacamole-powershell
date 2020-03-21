Function Remove-GuacConnectionGroupMember()
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
        [ValidateSet("READ",ignorecase=$true)]
        [Parameter(
            Position = 2,
            Mandatory = $true
        )]
        [System.String]
        $Permission,

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
        $Body = @{
          "op"= "remove"
          "path"= "/connectionGroupPermissions/$($ConnectionGroupId)"
          "value"= "$($Permission)"
        } | ConvertTo-Json

        $Body = "[$($Body)]"
        $Uri = "$Server/api/session/data/$($DataSource)/users/$Username/permissions?token=$($Token)"

    }
    process
    {

        try
        {
            $RestCall = Invoke-RestMethod -Method PATCH -Uri $Uri -ContentType 'application/json' -Body $Body
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

#Remove-GuacConnectionGroupMember -DataSource mysql -Username "john.doe" -Permission "READ" -ConnectionGroupId 1
