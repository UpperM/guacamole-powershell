Function Set-GuacComputerWakeOnLan()
{
    param(
        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 0,
            Mandatory = $True
        )]
        [System.String]
        $DataSource,

        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 1,
            Mandatory = $True
        )]
        [System.String]
        $Computer,

        [ValidateScript({$_ -match '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$'})]
        [Parameter(
            Position = 2,
            Mandatory = $True
        )]
        [System.String]
        $MacAddress,

        [ValidateScript({$_ -match '\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}\b'})]
        [Parameter(
            Position = 3,
            Mandatory = $True
        )]
        [System.String]
        $BroadcastAddress
    )

    begin
    {
        $GuacComputer = Get-GuacConnections -DataSource $DataSource | Where-Object {$_.name -eq $Computer}
        if (-Not $GuacComputer)
        {
            Write-Warning "Computer not found"
            return $False
        }

        $WolParameters = @{
            "wol-send-packet"="true"
            "wol-mac-addr"="$MacAddress"
            "wol-broadcast-addr"="$BroadcastAddress"
        }

        $WolParameters = New-Object PsObject -Property $WolParameters

        $GuacComputer | Add-Member -MemberType NoteProperty -Name "parameters" -Value $WolParameters

    }
    process
    {
        try
        {
            Update-GuacConnection -DataSource $DataSource -Parameters $GuacComputer -ConnectionId $GuacComputer.identifier
        }
        catch
        {
            Write-Warning $_.Exception.Message
            return $False
        }
    }
    end
    {
        return $True
    }
}
<#
Set-GuacComputerWakeOnLan -DataSource mysql -Computer "PC-001" -MacAddress "A4:BB:6D:7D:BF:6A" -BroadcastAddress "192.168.1.255"
#>
