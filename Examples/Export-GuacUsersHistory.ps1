<#
.SYNOPSIS
    Name: Export-GuacUsersHistory.ps1
    Export history of Guacamole users

.DESCRIPTION
    Export history of each Guacamole users

.NOTES
    Release Date: 2020-03-25
    Author: Matthieu Courtois

.EXAMPLE
    .\Export-GuacUsersHistory.ps1 -GuacUsername "guacadmin" -GuacPassword "MyPassword" -GuacServer "http://srv-guacamole:8080/guacamole" -GuacDataSource "mysql" -ExportCsvPath "C:\User_History.csv"

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
    $GuacUsername,

    [ValidateNotNullOrEmpty()]
    [Parameter(
        Position = 1,
        Mandatory = $True
    )]
    [System.String]
    $GuacPassword,

    [ValidateNotNullOrEmpty()]
    [Parameter(
        Position = 2,
        Mandatory = $True
    )]
    [System.String]
    $GuacServer,

    [ValidateNotNullOrEmpty()]
    [Parameter(
        Position = 3,
        Mandatory = $True
    )]
    [System.String]
    $GuacDataSource,

    [ValidateNotNullOrEmpty()]
    [Parameter(
        Position = 4,
        Mandatory = $False
    )]
    [System.String]
    $ExportCsvPath
)

Import-Module -Name PSGuacamole

$NewToken = New-GuacToken -Username $GuacUsername -Password $GuacPassword -Server $GuacServer
$UsersHistory = @()

if ($False -ne $NewToken)
{
    # Get history from all users
    $Users = Get-GuacUsers -DataSource $GuacDataSource
    foreach ($User in $Users)
    {
        Write-Output "Processing $($Username)"
        $Username = $User.username
        $UserHistory = Get-GuacConnectionsHistory -DataSource $GuacDataSource -Contains $Username
        $TotalSecond,$TotalHours = 0

        foreach ($h in $UserHistory)
        {
            # Convert to string
            if ($Null -ne $h.StartDate -or $Null -ne $h.EndDate)
            {
                $StartDate  = ($h.StartDate).ToString()
                $EndDate    = ($h.EndDate).ToString()

                # Remove the 000 at the end of the timestamp
                $StartDate  = $StartDate.Substring(0, $StartDate.Length - 3)
                $EndDate    = $EndDate.Substring(0, $EndDate.Length - 3)

                # Convert to date time
                $StartDate  = (Get-Date 01.01.1970)+([System.TimeSpan]::fromseconds($StartDate))
                $EndDate    = (Get-Date 01.01.1970)+([System.TimeSpan]::fromseconds($EndDate))

                # Get Total second of connection
                $TotalSecond    += ($EndDate - $StartDate).TotalSeconds
                $TotalHours     += ($EndDate - $StartDate).TotalHours
                $TotalHours     = [math]::Round($TotalHours,2)
            }

        }

        $Element = New-Object PSObject
        $Element | Add-Member -type NoteProperty -Name 'Username' -Value $Username
        $Element | Add-Member -type NoteProperty -Name 'TotalSecond' -Value $TotalSecond
        $Element | Add-Member -type NoteProperty -Name 'TotalHours' -Value $TotalHours
        $UsersHistory += $Element
    }
}


if ($ExportCsvPath)
{
    $UsersHistory | Export-Csv -Path $ExportCsvPath -Delimiter ';' -NoTypeInformation
}
