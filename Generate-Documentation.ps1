Write-Output $PSScriptRoot

$RootFolder = "$PSScriptRoot\PSGuacamole"

$Folders = Get-ChildItem -Path "$RootFolder\Public"

foreach ($Folder in $Folders)
{
    $TableContent       = ""
    $Content            = ""
    $DocumentationFile  = "$PSScriptRoot\Documentation\$Folder.md"
    Remove-Item  -Path $DocumentationFile
    $Title              = "# $Folder `n"
    $Functions          = Get-ChildItem -Path $Folder.FullName
    foreach ($Function in $Functions)
    {
        $FunctionName   = ($Function.Name).Replace(".ps1","")

        $TableContent   += " - [$FunctionName](#"+$FunctionName.toLower()+")`n"
        $Path           = $Function.FullName
        $TheStart       = (Select-String -Path $Path -Pattern '<#').lineNumber
        $TheEnd         = (Select-String -Path $Path -Pattern '#>').lineNumber
        Write-Warning "Processing $FunctionName $Path"
        $Example        = [string]::Join("`r`n",(Get-Content -Path $Path)[$TheStart..($TheEnd - 2)])
        $Content        += "## $FunctionName"
        $Example = $Example.Replace("#","")
        $Example = '
```Powershell
'+$Example+'
```'
        $Content += $Example + "`n"
    }

    Add-Content -Path $DocumentationFile -Value $Title
    Add-Content -Path $DocumentationFile -Value $TableContent
    Add-Content -Path $DocumentationFile -Value $Content
}
