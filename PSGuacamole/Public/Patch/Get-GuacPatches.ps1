Function Get-GuacPatches()
{
    param(
        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 1,
            Mandatory = $true
        )]
        [System.String]
        $Server
    )

    begin
    {
        $Uri = "$Server/api/patches"
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

#Get-GuacPatches
