function Add-HelixProjectModule
{
    param(
        [Parameter(Mandatory=$true)]
        [string]$project
    )

    $solution = Get-Interface $dte.Solution ([EnvDTE80.Solution2])
    $solutionFolder = Split-Path $solution.FullName -Parent

    $configFullFilePath = $solutionFolder + $global:solutionConfigName
    $config = Get-Content -Raw -Path $configFullFilePath | ConvertFrom-Json

    $parentProject = Get-SolutionFolderForModuleCreation $global:ProjectFolderName
    $parentSolutionFolder = Get-Interface $parentProject.Object ([EnvDTE80.SolutionFolder])

    $newFolder = $solutionFolder + $global:projectPath + $project + $global:codeFolder
    $projectName = $config.solutionName + "." + $project + "." + $global:websiteName
    $tdsProjectName = $config.solutionName + "." +$project +"." +$global:tdsProjectName

    $parentSolutionFolder = Get-Interface $parentProject.Object ([EnvDTE80.SolutionFolder])
    $childProject = $parentSolutionFolder.AddSolutionFolder($project)
    $childSolutionFolder = Get-Interface $childProject.Object ([EnvDTE80.SolutionFolder])

    $projectFile = $childSolutionFolder.AddFromTemplate($global:webTemplate,$newFolder, $projectName);

    $newFolder = $solutionFolder + $global:projectPath + $project + $global:serializationFolder + $global:tdsProjectName
    $projectFile = $childSolutionFolder.AddFromTemplate($global:tdstemplate,$newFolder, $tdsProjectName);

    $tdsRootFolderPath = $solutionFolder + $global:projectPath + $project + $global:serializationFolder
    $tdsProjectRoot = $config.solutionName + "." +$feature
    Add-TdsProjectsForModules $childSolutionFolder $tdsRootFolderPath $tdsProjectRoot
}

Export-ModuleMember -Function Add-HelixProjectModule