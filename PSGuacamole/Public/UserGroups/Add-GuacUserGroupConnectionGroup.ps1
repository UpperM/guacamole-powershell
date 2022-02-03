Function Add-GuacUserGroupConnectionGroup()
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
        $ConnectionGroupName
    )

    begin
    {
        $Body = @()

        # 1. Get ConnectionGroup information
        $ConnectionGroup = Get-GuacConnectionsGroups -DataSource $DataSource | Where-Object {$_.name -eq $ConnectionGroupName}

        $Body+= @{
            "op"= "add"
            "path"= "/connectionGroupPermissions/$($ConnectionGroup.identifier)"
            "value"= "READ"
        }

        # 2. Check if the ConnectionGroup has parents
        if ($ConnectionGroup.parentIdentifier -ne 'ROOT')
        {
            # He has parents !
        }

        # 3. Retrive connections of Connection Group
        $Connections = Get-GuacConnectionsGroupsConnections -DataSource $DataSource | Where-Object {$_.name -eq $ConnectionGroupName}

        $ChildConnections = $Connections.childConnections
        $ChildConnectionGroups = $Connections.childConnectionGroups

        foreach ($ChildConnectionGroup in $ChildConnectionGroups) {

            $Body+= @{
                "op"= "add"
                "path"= "/connectionGroupPermissions/$($ChildConnectionGroup.identifier)"
                "value"= "READ"
            }

            $ChildConnections += $ChildConnectionGroup.childConnections
        }

        foreach ($ChildConnection in $ChildConnections) {
            $Body+= @{
                "op"= "add"
                "path"= "/connectionPermissions/$($ChildConnection.identifier)"
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
Add-GuacUserGroupConnectionGroup -DataSource mysql -ConnectionId 52 -Group "test"
#>
