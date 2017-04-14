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

# TODO: write to config file that users can update with local paths or find way to grab these from file system
$global:classTemplate = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\ProjectTemplates\CSharp\Windows\1033\ClassLibrary\csClassLibrary.vstemplate"
$global:webTemplate = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\ProjectTemplates\CSharp\Web\1033\WebApplicationProject40\EmptyWebApplicationProject40.vstemplate"
$global:tdstemplate = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\Extensions\i01faqhl.m5f\ProjectTemplates\TDS Project\TDS Project.vstemplate"

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