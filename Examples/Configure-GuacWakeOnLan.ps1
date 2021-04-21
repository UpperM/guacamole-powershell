<#
.SYNOPSIS
    Name: Configure-GuacWakeOnLan.ps1
    Enable Wake On lan on computer

.DESCRIPTION

    This script use Windows DHCP to get MAC adress and IP of computer and set Guacamole WOL parameters.
    WARNING : This script doesn't calculte the broadcast, only replace last octect by 255, assuming is a /24 network

.NOTES
    Release Date: 2021-04-21
    Author: Matthieu Courtois

.EXAMPLE
    .\Configure-GuacWakeOnLan.ps1 -DataSource mysql -Computer "PC-001" -MacAddress "A4:BB:6D:7D:BF:6A" -BroadcastAddress "192.168.1.255"

.NOTES
    This script require somes modules :
        - PSGuacamole https://github.com/UpperM/guacamole-powershell

#>


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
        Position = 0,
        Mandatory = $True
    )]
    [System.String]
    $Computer,

    [ValidateScript({$_ -match '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$'})]
    [Parameter(
        Position = 1,
        Mandatory = $True
    )]
    [System.String]
    $MacAddress,

    [ValidateScript({$_ -match '\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}\b'})]
    [Parameter(
        Position = 1,
        Mandatory = $True
    )]
    [System.String]
    $BroadcastAddress
)


$GuacComputer = Get-GuacConnections -DataSource $DataSource | Where-Object {$_.name -eq $Computer}

if ($GuacComputer)
{

    $WolParameters = @{
        "wol-send-packet"="true"
        "wol-mac-addr"="$MacAddress"
        "wol-broadcast-addr"="$BroadcastAddress"
    }

    $WolParameters = New-Object PsObject -Property $WolParameters

    $GuacComputer | Add-Member -MemberType NoteProperty -Name "parameters" -Value $WolParameters

    Update-GuacConnection -DataSource $DataSource -Parameters $GuacComputer -ConnectionId $GuacComputer.identifier

} else
{
    Write-Warning "Computer not found"
}
