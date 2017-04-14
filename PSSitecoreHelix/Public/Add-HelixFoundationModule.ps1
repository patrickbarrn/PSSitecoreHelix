function Add-HelixFoundationModule
{
    param(
        [Parameter(Mandatory=$true)]
        [string]$foundation
    )

    $solution = Get-Interface $dte.Solution ([EnvDTE80.Solution2])
    $solutionFolder = Split-Path $solution.FullName -Parent

    $configFullFilePath = $solutionFolder + $global:solutionConfigName
    $config = Get-Content -Raw -Path $configFullFilePath | ConvertFrom-Json

    $parentProject = Get-SolutionFolderForModuleCreation $global:FoundationFolderName
    $parentSolutionFolder = Get-Interface $parentProject.Object ([EnvDTE80.SolutionFolder])

    $newFolder = $solutionFolder + $global:foundationPath + $foundation + $global:codeFolder
    $projectName = $config.FoundationPrefix + "." + $foundation
    $testsProjectName = $config.FoundationPrefix + "." + $foundation + "." + $global:testProjectName
    $tdsProjectName = $config.FoundationPrefix + "." +$foundation +"." +$global:tdsProjectName

    $childProject = $parentSolutionFolder.AddSolutionFolder($foundation)
    $childSolutionFolder = Get-Interface $childProject.Object ([EnvDTE80.SolutionFolder])
    
    $projectFile = $childSolutionFolder.AddFromTemplate($global:webTemplate,$newFolder, $projectName);

    $tdsRootFolderPath = $solutionFolder + $global:foundationPath + $foundation + $global:serializationFolder
    $tdsProjectRoot = $config.foundationPrefix + "." +$foundation
    Add-TdsProjectsForModules $childSolutionFolder $tdsRootFolderPath $tdsProjectRoot

    $newFolder = $solutionFolder + $global:foundationPath + $foundation + $global:testsFolder
    $projectFile = $childSolutionFolder.AddFromTemplate($global:classTemplate,$newFolder, $testsProjectName);
}

Export-ModuleMember -Function Add-HelixFoundationModule