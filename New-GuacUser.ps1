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
Set-Location $PSScriptRoot
. .\Invoke-GuacAPI.ps1

$NewGuacToken = New-GuacToken -Username "admin" -Password "MyPassword" -Server "http://srv-guacamole:8080/guacamole"

$Username = "john.doe"
$Password = "MyPassword"
$DataSource = "mysql"

if ($NewGuacToken)
{
    $GetGuacUser = Get-GuacUser -Username $Username -DataSource $DataSource # Check if user already exist
    if ($GetGuacUser -eq $False)
    {
        # Create the user if not exist
        try
        {
            New-GuacUser -Username $Username -Password $Password -DataSource $DataSource
            Write-Output "Creation of $($Username) done in Guacamole"
        }
        catch
        {
            Write-Warning "Failed to create $($Username) in Guacamole"
        }
    } else
    {
        Write-Output "$($Username) already exists in Guacamole"
    }
}
