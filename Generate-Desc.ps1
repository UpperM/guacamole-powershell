

$Folders = Get-ChildItem -Path $PSScriptRoot\Public
Import-Module PSGuacamole

Write-Output "## Functions"
foreach ($f in $Folders)
{$Count = 0
    Write-Output "  * [$f]($f)"
    $Item = Get-ChildItem $PSScriptRoot\Public\$f
    foreach ($i in $Item)
    {
        $Count++
        $Name = ($i.Name).Replace(".ps1","")
        #Write-Output $h
        #Write-Output "* $Name"

    }
}
