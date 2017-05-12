function Add-TdsProjectsForModules
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        $solutionFolder,
        [Parameter(Mandatory=$true)]
        [string]$folderPath,
        [Parameter(Mandatory=$true)]
        [string]$tdsProjectRoot
    )
    
    $tdsProjectNames = New-Object System.Collections.ArrayList
    
    $input = ""
    do
    {
        Clear-Host
         $input = Read-Host "Enter a TDS Project name or q to continue. (i.e. Master or Core)"
         if ($input -eq 'q')
         {
            break         
         }
         elseif (-not([string]::IsNullOrWhiteSpace($input)))
         {
               $tdsProjectNames.Add($input)
         }
    }
    until ($input -eq 'q')

    foreach ($tdsProjectName in $tdsProjectNames)
    {
        $tdsFullProjName = $tdsProjectRoot + ".TDS." + $tdsProjectName
        $newFolder = $folderPath + "TDS." + $tdsProjectName

        $solutionFolder.AddFromTemplate($global:tdstemplate, $newFolder, $tdsFullProjName);
    }
}

Export-ModuleMember -Function Add-TdsProjectsForModules