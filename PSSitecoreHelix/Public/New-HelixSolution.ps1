function New-HelixSolution
{
    $helixPath = Get-HelixFoundationFolder
    $solutionName = Get-HelixSolutionUserInput "Please specify you solution name. This could be the company name or overall solution name. e.g. Acme or MSFT" "Empty solution name. Try again."
    $foundationNamePrefix = Get-HelixSolutionUserInput "Please specify you foundation name prefix. e.g. $solutionName.Foundation" "Empty foundation name prefix. Try again."
    $featureNamePrefix = Get-HelixSolutionUserInput "Please specify you feature name prefix. e.g.$solutionName.Feature" "Empty feature name prefix. Try again."
    
    Clear-Host
    Write-Host "Solution Name:" $solutionName
    Write-Host "Foundation Name Prefix:" $foundationNamePrefix
    Write-Host "Feature Name Prefix:" $featureNamePrefix

    Write-Host "================ Create Helix Solution? ================"
    Write-Host "1: Continue"
    Write-Host "q: Press 'q' to Quit"

    $input = Read-Host "Enter 1 to continue or q to exit."
    if ($input -eq 'q')
    {
        exit
    }
    elseif ($input -eq '1')
    {
        $dte.Solution.Create($helixPath, $solutionName)
        $solution = $dte.Solution
        $dte.ExecuteCommand("File.SaveAll")

        foreach ($path in $folderPaths)
        {
            $newFolder = $helixPath + $path
            New-Item -ItemType Directory -Path $newFolder -Force
        }

        $config = @{
            "solutionName" = $solutionName
            "foundationPrefix" = $foundationNamePrefix
            "featurePrefix" = $featureNamePrefix
        }
        $configFullFilePath = $helixPath + $solutionConfigName
        $config | ConvertTo-Json -depth 2 | Out-File $configFullFilePath

        $solution = Get-Interface $dte.Solution ([EnvDTE80.Solution2])
        $parentFolder = $solution.AddSolutionFolder($ConfigFolderName)
        $parentProject = $solution.AddSolutionFolder($FoundationFolderName)
        $parentProject = $solution.AddSolutionFolder($FeatureFolderName)
        $parentProject = $solution.AddSolutionFolder($ProjectFolderName)
        
        $dte.ExecuteCommand("File.SaveAll")
    }
}

<# 
    private functions only used in the cmdlet 
#>

function Get-HelixFoundationFolder
{
    #get path and validate the path
    $input = Read-Host "Please specify the path to an empty folder"

    if($input -eq "")
    {
        Write-Host "Select a valid folder path."
        exit
    }

    if ( -not (Test-Path $input -PathType Container) ) 
    { 
        Write-Host "Select a valid folder."
        exit
    }

    $directoryInfo = Get-ChildItem $input | Measure-Object
    if ($directoryInfo.count -gt 0)
    {
        Write-Host "Folder is not empty."
        exit
    }

    return $input
}

function Get-HelixSolutionUserInput
{
    param (
        [Parameter(Mandatory=$True)]
        [string]$question,
        [Parameter(Mandatory=$True)]
        [string]$errorMsg
    )

    Clear-Host

    $input = Read-Host $question
    do
    {
        if([string]::IsNullOrWhiteSpace($input))
        {
            Write-Host $errorMsg
        }
        else
        {
            return $input
        }
    }
    until (-not([string]::IsNullOrWhiteSpace($input)))

}

Export-ModuleMember -Function New-HelixSolution