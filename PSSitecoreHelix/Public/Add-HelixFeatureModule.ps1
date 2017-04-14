function Add-HelixFeatureModule
{
    param(
        [Parameter(Mandatory=$true)]
        [string]$feature
    )

    $solution = Get-Interface $dte.Solution ([EnvDTE80.Solution2])
    $solutionFolder = Split-Path $solution.FullName -Parent

    $configFullFilePath = $solutionFolder + $global:solutionConfigName
    $config = Get-Content -Raw -Path $configFullFilePath | ConvertFrom-Json

    $parentProject = Get-SolutionFolderForModuleCreation $global:FeatureFolderName
    $parentSolutionFolder = Get-Interface $parentProject.Object ([EnvDTE80.SolutionFolder])

    $newFolder = $solutionFolder + $global:featurePath + $feature + $global:codeFolder
    $projectName = $config.featurePrefix + "." + $feature
    $testsProjectName = $config.featurePrefix + "." + $feature + "." + $global:testProjectName
    $tdsProjectName = $config.featurePrefix + "." +$feature +"." +$global:tdsProjectName

    $childProject = $parentSolutionFolder.AddSolutionFolder($feature)
    $childSolutionFolder = Get-Interface $childProject.Object ([EnvDTE80.SolutionFolder])
    
    $projectFile = $childSolutionFolder.AddFromTemplate($global:webTemplate, $newFolder, $projectName);

    $tdsRootFolderPath = $solutionFolder + $global:featurePath + $feature + $global:serializationFolder
    $tdsProjectRoot = $config.featurePrefix + "." +$feature
    Add-TdsProjectsForModules $childSolutionFolder $tdsRootFolderPath $tdsProjectRoot
        
    $newFolder = $solutionFolder + $global:featurePath + $feature + $global:testsFolder
    $projectFile = $childSolutionFolder.AddFromTemplate($global:classTemplate, $newFolder, $testsProjectName);
}

Export-ModuleMember -Function Add-HelixFeatureModule