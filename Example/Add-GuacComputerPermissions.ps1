<#
    .SYNOPSIS
        Allow user to connect to specified computer

    .DESCRIPTION
        Create new user in Apache Guacamole and new RDP Computer

    .LINK

    .NOTES
        Release Date: 2020-03-20
        Author: Matthieu Courtois

    .EXAMPLE

#>


# LOAD Guacamole Function
. .\Invoke-GuacAPI.ps1

$NewGuacToken = New-GuacToken -Username "admin" -Password "MyPassword" -Server "http://srv-guacamole:8080/guacamole"

$Username   = "john.doe"
$Computer = "JOHN-COMPUTER" # Computer name
$DataSource = "mysql"


$GetGuacUser        = Get-GuacUser -Username $Username -DataSource $DataSource
$GetGuacComputer    = Get-GuacComputer -Computer $Computer -DataSource $DataSource

# If the user and the computer already exist in Guacamole
if (($GetGuacComputer -ne $False) -and ($GetGuacUser -ne $False))
{
    $ComputerId = $GetGuacComputer.identifier

    $AddGuacPermissions = Add-GuacUserPermissions -Username $Username -Computer $ComputerId -DataSource $DataSource -Permission "READ"
    if ($AddGuacPermissions)
    {
        Write-Output "Added Gucamole permissions for $($Username) on $($Computer)"
    } else
    {
        Write-Warning "Error when adding permissions on $($Computer) for $($Username)"
        return $False
    }
} else
{
    Write-Warning "$Username or $Computer don't exist"
    return $False
}
