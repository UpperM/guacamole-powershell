Function Add-GuacUserGroupConnection()
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
        $Group,

        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 2,
            Mandatory = $true
        )]
        [System.String]
        $ConnectionId
    )

    begin
    {
        # Get parent identifier of connection
        $ParentIdentifier = (Get-GuacConnection -ConnectionId $ConnectionId -DataSource $DataSource).parentIdentifier
        $Parents = @($ParentIdentifier)

        # Let's search for parents of connection
        while ($ParentIdentifier -ne 'ROOT')
        {
            $ParentInformation = Get-GuacConnectionsGroup -DataSource $DataSource -ConnectionGroupId $ParentIdentifier
            $ParentIdentifier = $ParentInformation.parentIdentifier

            if($ParentIdentifier -ne 'ROOT')
            {
                # Add parentId to $Parents array
                $Parents += $ParentIdentifier
            }
        }

        $ConnectionPermission = @{
            "op"= "add"
            "path"= "/connectionPermissions/$($ConnectionId)"
            "value"= "READ"
        }

        $Body = @($ConnectionPermission)
        foreach ($Parent in $Parents)
        {
            $Body+= @{
                "op"= "add"
                "path"= "/connectionGroupPermissions/$($Parent)"
                "value"= "READ"
            }
        }
        $Body = $Body | ConvertTo-Json

        $Uri = "$Server/api/session/data/$($DataSource)/userGroups/$Group/permissions?token=$($Token)"

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

<#
Add-GuacUserGroupConnection -DataSource mysql -ConnectionId 52 -Group "test"
#>
