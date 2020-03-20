<#
    .SYNOPSIS
        Functions to call Apache Guacamole API

    .DESCRIPTION
        Functions to call Apache Guacamole API

    .LINK

    .NOTES
        Release Date: 2020-03-20

        Author: Matthieu Courtois

    .NOTES

#>

Function New-GuacToken()
{
    param(
        [Parameter(Position=0,mandatory=$true)]
        [System.String]$Username,

        [Parameter(Position=1,mandatory=$true)]
        [System.String]$Password,

        [Parameter(Position=2,mandatory=$true)]
        [System.String]$Server
    )

    $body = @{
        username = $Username
        password = $Password
    }
    $script:GUAC_URL = $Server
    $EndPoint       = "$Server/api/tokens"
    $contentType    = 'application/x-www-form-urlencoded'

    try {
        $Json = Invoke-WebRequest -Method POST -ContentType $contentType -Body $Body -Uri $EndPoint
    }
    catch {
        $ErrorCode = $_.Exception.Response.StatusCode.value__
        Write-Warning "Unable to connect to API"
        if ($ErrorCode -eq "403")
        {
            Write-Warning "Incorrect user or password"
        } elseif ($ErrorCode -eq "404")
        {
            Write-Warning "Incorrect server address"
        }
        return $False
    }

    $script:Token   = (ConvertFrom-Json -InputObject $Json.Content).authToken
    return $True
}

Function New-GuacUser()
{
    param(
        [Parameter(Position=0,mandatory=$true)]
        [System.String]$Username,

        [Parameter(Position=1,mandatory=$False)]
        [System.String]$Password,

        [Parameter(Position=2,mandatory=$true)]
        [System.String]$DataSource
    )

    $EndPoint = "api/session/data/$($DataSource)/users"
    $Body = @{
        "username"= "$Username";
        "password"= "$Password";
        "attributes"=  @{
           "disabled"= "";
           "expired"= "";
           "access-window-start"= "";
           "access-window-end"= "";
           "valid-from"= "";
           "valid-until"= "";
           "timezone"= "";
       }
    } | ConvertTo-Json

    $Call = New-RestCall -EndPoint $Endpoint -Method POST -Body $Body
    if ($Call.StatusCode -eq 200)
    {
        return ConvertFrom-Json -InputObject $Call.Content
    }

    return $False
}

Function Get-GuacUser()
{
    param(
        [Parameter(Position=0,mandatory=$true)]
        [System.String]$Username,

        [Parameter(Position=1,mandatory=$true)]
        [System.String]$DataSource
    )

    $EndPoint = "api/session/data/$($DataSource)/users/$Username"

    $Call = New-RestCall -EndPoint $Endpoint -Method GET
    if ($Call.StatusCode -eq 200)
    {
        return ConvertFrom-Json -InputObject $Call.Content
    }

    return $False
}

Function Remove-GuacUser()
{
    param(
        [Parameter(Position=0,mandatory=$true)]
        [System.String]$Username,

        [Parameter(Position=1,mandatory=$true)]
        [System.String]$DataSource
    )

    $EndPoint = "api/session/data/$($DataSource)/users/$Username"

    $Call = New-RestCall -EndPoint $Endpoint -Method DELETE
    if ($Call.StatusCode -eq 204)
    {
        return $True
    }

    return $False

}

Function New-RestCall()
{
    param(
        [System.String]$EndPoint,
        [System.String]$Method,
        [System.Array]$Body
    )

    $endPoint = "$GUAC_URL/$EndPoint/?token=$Token"
    Write-Output "end : $endPoint"
    try
    {
        $Call = Invoke-WebRequest -Method $Method -ContentType 'Application/Json;charset=utf-8' -Body $Body -Uri $endPoint
    }
    catch
    {
        $ErrorCode = $_.Exception.Response.StatusCode.value__

        if ($ErrorCode -eq "403")
        {
            Write-Warning "Incorrect user or password (ERROR 403)"
        } elseif ($ErrorCode -eq "404")
        {
            Write-Warning "Incorrect request (ERROR 404) ($endPoint)"
        }
        return $False
    }

    return $Call
}

Function New-GuacRdpComputer()
{
    param(
        [Parameter(Position=0,mandatory=$true)]
        [System.String]$Computer,

        [Parameter(Position=1,mandatory=$False)]
        [System.string]$Password,

        [Parameter(Position=2,mandatory=$False)]
        [System.String]$Username,

        [Parameter(Position=3,mandatory=$true)]
        [System.String]$DataSource,

        [Parameter(Position=4,mandatory=$False)]
        [System.String]$Security = "nla"
    )

    $EndPoint = "api/session/data/$($DataSource)/connections"
    $Body = @{
        "name"="$Computer";
        "identifier"="";
        "parentIdentifier"="ROOT";
        "protocol"="rdp";
        "attributes"= @{
            "max-connections"="";"max-connections-per-user"=""
        };
        "activeConnections"=0;
        "parameters"= @{
            "disable-audio"="";
            "server-layout"="";
            "domain"="";
            "hostname"="$($Computer)";
            "enable-font-smoothing"="";
            "security"="$($Security)";
            "port"="3389";
            "disable-auth"="";
            "ignore-cert"="true";
            "password"="$($Password)";
            "username"="$($Username)"
        }
    } | ConvertTo-Json

    $Call = New-RestCall -EndPoint $Endpoint -Method POST -Body $Body
    if ($Call.StatusCode -eq 200)
    {
        return ConvertFrom-Json -InputObject $Call.Content
    }

    return $False

}

Function Get-GuacComputers()
{
    param(
        [Parameter(Position=0,mandatory=$true)]
        [System.String]$DataSource
    )

    $EndPoint = "api/session/data/$($DataSource)/connections"

    $Call = New-RestCall -EndPoint $Endpoint -Method GET
    if ($Call.StatusCode -eq 200)
    {
        return $Call.Content | ConvertFrom-Json
    }

    return $False
}

Function Get-GuacComputer()
{
    param(
        [Parameter(Position=0,mandatory=$true)]
        [System.String]$Computer,
        [Parameter(Position=1,mandatory=$true)]
        [System.String]$DataSource
    )

    $Computers = Get-GuacComputers -DataSource $DataSource

    foreach ($i in $Computers.PsObject.Properties)
    {
        if ($i.Value.Name -eq $Computer)
        {
            return $i.Value
        }
    }

    return $False
}

Function Remove-GuacCompter()
{
    param(
        [Parameter(Position=0,mandatory=$true)]
        [System.String]$ComputerId,
        [Parameter(Position=1,mandatory=$true)]
        [System.String]$DataSource
    )

    $EndPoint = "api/session/data/$($DataSource)/connections/$ComputerId"

    $Call = New-RestCall -EndPoint $Endpoint -Method DELETE
    if ($Call.StatusCode -eq 204)
    {
        return $True
    }

    return $False

}

Function Get-GuacConnectionGroups()
{
    param(
        [Parameter(Position=1,mandatory=$true)]
        [System.String]$DataSource
    )

    $Endpoint = "api/session/data/$($DataSource)/connectionGroups"

    $Call = New-RestCall -EndPoint $Endpoint -Method GET

    return $Call.Content | ConvertFrom-Json
}
Function Add-GuacUserPermissions()
{
    param(
        [Parameter(Position=0,mandatory=$true)]
        [System.String]$Username,
        [Parameter(Position=1,mandatory=$true)]
        [System.String]$ComputerID,
        [Parameter(Position=2,mandatory=$False)]
        [System.String]$Permission = "READ",
        [Parameter(Position=3,mandatory=$true)]
        [System.String]$DataSource
    )


    $EndPoint = "api/session/data/$($DataSource)/users/$Username/permissions"
    $Body = '[
        {
            "op":"add",
            "path":"/connectionPermissions/'+$ComputerID+'",
            "value":"'+$($Permission)+'"

        }
    ]'

    $Call = New-RestCall -EndPoint $Endpoint -Method PATCH -Body $Body
    $Call
    if ($Call.StatusCode -eq 204)
    {
        return $True
    } else
    {
        return $False
    }

}

Function Get-GuacActiveConnections()
{
    param(
        [Parameter(Position=0,mandatory=$True)]
        [System.String]$DataSource
    )
    $Endpoint = "api/session/data/$($DataSource)/activeConnections"
    $Call = New-RestCall -EndPoint $Endpoint -Method GET
    return $Call.Content
}
