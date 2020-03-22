Function Remove-GuacToken()
{
    param(
        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 0,
            Mandatory = $true
        )]
        [System.String]
        $Token
    )

    begin
    {
        $Uri = "$Server/api/tokens"
    }
    process
    {

        try
        {
            Invoke-RestMethod -Method DELETE -Body $Body -Uri $Uri
        }
        catch
        {
            Write-Warning $_.Exception.Message
            return $False
        }

    }
    end
    {
    }
}
<#
Remove-GuacToken -Token $TokenToRemove -Server "http://srv-guacamole:8080/guacamole"
#>
