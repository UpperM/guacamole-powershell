
<#
.SYNOPSIS
    Name: Enable-GuacWolOnComputers.ps1
    Fetch computers IP Broadcast and Mac adress from Windows DHCP server and enable WoL in guacamole

.DESCRIPTION
    This script query DNS to get computer IP. Then with the IP, we search in DHCP to get ScopeId and mac address
    With scopeID we got network address and mask to calculate broadcast address.
    Push all informations to guacamole to enable wake on lan

.NOTES
    Release Date: 2021-04-21
    Author: Matthieu Courtois

.EXAMPLE
    .\Enable-GuacWolOnComputers.ps1 -GuacUsername "guacadmin" -GuacPassword "MyPassword" -GuacServer "http://srv-guacamole:8080/guacamole" -GuacDataSource "mysql" -DHCPServer "192.168.1.1"

.NOTES
    This script require somes modules :
        - PSGuacamole https://github.com/UpperM/guacamole-powershell

#>

param(
    [ValidateNotNullOrEmpty()]
    [Parameter(
        Position = 0,
        Mandatory = $true
    )]
    [System.String]
    $GuacUsername,

    [ValidateNotNullOrEmpty()]
    [Parameter(
        Position = 1,
        Mandatory = $true
    )]
    [System.String]
    $GuacPassword,

    [ValidateNotNullOrEmpty()]
    [Parameter(
        Position = 2,
        Mandatory = $true
    )]
    [System.String]
    $GuacServer,

    [ValidateNotNullOrEmpty()]
    [Parameter(
        Position = 3,
        Mandatory = $true
    )]
    [System.String]
    $GuacDataSource,

    [ValidateNotNullOrEmpty()]
    [Parameter(
        Position = 4,
        Mandatory = $false
    )]
    [System.String]
    $DHCPServer
)

Import-Module -Name PSGuacamole

# Enabling Tls2 for Windows Server 2012 R2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$NewToken = New-GuacToken -Username $GuacUsername -Password $GuacPassword -Server $GuacServer

if ($False -ne $NewToken)
{
    $GuacComputers = Get-GuacConnections -DataSource $GuacDataSource

    foreach ($i in $GuacComputers)
    {
        Write-Output "============== $($i.name) =============="
        # Search computer in DNS to get IP Address
        $DNSRecord = Resolve-DnsName -Name $i.name -ErrorAction SilentlyContinue -Type A

        if ($Null -eq $DNSRecord)
        {
            Write-Warning "Not found in DNS"
            continue
        }
        $DNSHostname = ($DNSRecord.Name).ToLower()

        # Search computer in DHCP to get MAC Address
        $DHCPComputerInfos = Get-DhcpServerv4Lease -IPAddress $DNSRecord.IPAddress -ComputerName $DHCPServer -ErrorAction SilentlyContinue
        if ($Null -eq $DHCPComputerInfos)
        {
            Write-Warning "$DNSHostname not found in DHCP"
            continue
        }

        $DHCPHostname = ($DHCPComputerInfos.HostName).ToLower()
        # Check if hostname match DHCP lease
        if ($DNSHostname -ne $DHCPHostname)
        {
            Write-Warning "DNS record ($DNSHostname) doesn't match lease in DHCP ($DHCPHostname)"
            continue
        }

        $MacAddress = $DHCPComputerInfos.ClientId -replace ('-',':')

        Write-Output "$DNSHostname has mac $MacAddress"

        # Get DHCP scope settings
        $DHCPScopeInfos = Get-DhcpServerv4Scope -ScopeId $DHCPComputerInfos.ScopeId -ComputerName $DHCPServer

        # Broadcast address
        filter Convert-IP2Decimal
        {
            ([IPAddress][String]([IPAddress]$_)).Address
        }
        filter Convert-Decimal2IP
        {
            ([System.Net.IPAddress]$_).IPAddressToString
        }

        [UInt32]$IP = $DNSRecord.IPAddress | Convert-IP2Decimal
        [UInt32]$Subnet = $DHCPScopeInfos.SubnetMask | Convert-IP2Decimal
        [UInt32]$Broadcast = $IP -band $Subnet
        $BroadcastAddress = $Broadcast -bor -bnot $subnet | Convert-Decimal2IP

        # Enable WoL
        Write-Output "Enabling Wake On Lan for $($i.name)"
        Set-GuacComputerWakeOnLan -DataSource $GuacDataSource -ConnectionId $i.identifier -MacAddress $MacAddress -BroadcastAddress $BroadcastAddress
    }
}
