Function New-GuacToken()
{
    param(
        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 0,
            Mandatory = $true
        )]
        [System.String]
        $Username,

        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 1,
            Mandatory = $true
        )]
        [System.String]
        $Password,

        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 2,
            Mandatory = $true
        )]
        [System.String]
        $Server
    )

    begin
    {
        $Body = @{
            username = $Username
            password = $Password
        }

        $Uri = "$Server/api/tokens"
    }
    process
    {

        try
        {
            $RestCall = Invoke-RestMethod -Method POST -Body $Body -Uri $Uri
        }
        catch
        {

            Write-Warning $_.Exception.Message
            return $False
        }

    }
    end
    {
        $Global:Token = $RestCall.authToken
        $Global:Server = $Server
        return $RestCall
    }
}

<#
New-GuacToken -Username guacadmin -Password guacadmin -Server "http://srv-guacamole:8080/guacamole"
#>
