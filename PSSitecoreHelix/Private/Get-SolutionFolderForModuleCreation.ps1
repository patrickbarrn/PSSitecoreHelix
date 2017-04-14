function Get-SolutionFolderForModuleCreation
{
    param (
        [string]$Name
    )
    return $dte.Solution.Projects | Where-Object { $_.Kind -eq [EnvDTE80.ProjectKinds]::vsProjectKindSolutionFolder -and $_.Name -eq $Name } | Select-Object -First 1
}

Export-ModuleMember -Function Get-SolutionFolderForModuleCreation