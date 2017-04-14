# PSSitecoreHelix

A Powershell Cmdlet to run inside Visual Studio the generate fast and simple Sitecore Solutions based on the Helix principles and conventions.

## Getting Started

- Dependencies:
    - Powershell 5
    - Visual Studio 2017
- Clone/download repository to local file system
- In Visual Studio open NuGet's "Package Manager Console" and type "$profile"
- Open the Powershell file (note you may have to create the folder and/or the script file) in a text editor
- Add the following lines to the file and save
    - Import-Module {path to module}\PSSitecoreHelix.psm1
    - (optional) Get-Command -Module PSSitecoreHelix
- Save and restart Visual Studio

## Available Cmdlet options
- New-HelixSolution
    - Creates a Visual Stuido Solution file and sets up the Helix folder structure on the file system and in the solution. 
- Add-HelixFeatureModule
    - Add a new Helix Feature Module. Includes the web project, a test project, and specified TDS projects needed for the feature
- Add-HelixFoundationModule
    - Add a new Helix Foundation Module. Includes the web project, a test project, and specified TDS projects needed for the foundation
- Add-TdsProjectsForModules
    - Add a new Helix Project Module. Includes the web project, a test project, and specified TDS projects needed for the project
