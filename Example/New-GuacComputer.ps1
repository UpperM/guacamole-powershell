<#
    .SYNOPSIS
        Create user and computer

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

$Username = "john.doe" # Username used for rdp connection
$Password = "MyPassword" # Password used for rdp connection
$Computer = "JOHN-COMPUTER" # Hostname or IP
$DataSource = "mysql"

if ($NewGuacToken)
{
    $GetGuacComputer = Get-GuacComputer -Computer $Computer -DataSource $DataSource # Check if Computer already exist
    if ($GetGuacComputer -eq $False)
    {
        # Create the computer if not exist
        try
        {
            New-GuacRdpComputer -Computer $Computer -Username $Username -Password $Password -DataSource $DataSource
            Write-Output "Creation of $($Computer) done in Guacamole"
        }
        catch
        {
            Write-Warning "Failed to create $($Computer) in Guacamole"
        }
    } else
    {
        Write-Output "Computer $($Computer) already exists in Guacamole"
    }

}
