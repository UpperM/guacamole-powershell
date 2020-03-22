Write-Output $PSScriptRoot

$RootFolder = "$PSScriptRoot\PSGuacamole"

$Folders = Get-ChildItem -Path "$RootFolder\Public"

foreach ($Folder in $Folders)
{
    $Title              = "# $Folder `n"
    Write-Output "  * [$Folder](Documentation/$Folder.md)"

}
