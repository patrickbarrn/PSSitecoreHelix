#Get public and private function definition files.
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
Foreach($import in @($Public + $Private))
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

# Visual Studio template for project setup
$global:classTemplate = $dte.Solution.GetProjectTemplate("csClassLibrary.vstemplate", "CSharp")
$global:webTemplate = $dte.Solution.GetProjectTemplate("EmptyWebApplicationProject40.vstemplate", "CSharp")
$global:tdstemplate = $dte.Solution.GetProjectTemplate("TDS Project.vstemplate", "TDS Project")

# global variables for module

$global:folderPaths = @("\scripts","\specs","\src\Feature","\src\Foundation","\src\Project")

$global:projectPath = "\src\Project\"
$global:foundationPath = "\src\Foundation\"
$global:featurePath = "\src\Feature\"
$global:srcFolder = "\src"
$global:codeFolder = "\code"
$global:serializationFolder = "\serialization\"
$global:testsFolder = "\Tests"
$global:solutionConfigName = "\scripts\config.json"


$global:testProjectName = "Tests"
$global:tdsProjectName = "TDS.Master"
$global:websiteName = "Website"

$global:ConfigFolderName = "Configuration"
$global:FeatureFolderName = "Feature"
$global:FoundationFolderName = "Foundation"
$global:ProjectFolderName = "Project"

Export-ModuleMember -Function $Public.Basename