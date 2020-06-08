<#
 .Synopsis
  Create a new C Project.

 .Description
  Creates the folder structure for a new C Project.

 .Parameter name
  The name of the new project.
  
 .Example
  # Create a new project called ServerTools.
  New-Project ServerTools
#>

Function New-CProject {
    [CmdletBinding()]
    param(
        [Parameter(mandatory = $true)]
        [string] $name,
        [Parameter(ParameterSetName='-small',Mandatory=$false)][Switch]$small,
        [Parameter(ParameterSetName='-medium',Mandatory=$false)][Switch]$medium,
        [Parameter(ParameterSetName='-large',Mandatory=$false)][Switch]$large
    )
	
    Process {
        if (1 -ne $small.IsPresent + $medium.IsPresent + $large.IsPresent) {
            'Usage: script.ps1 {-i|-ir|iur}'
            exit 1
        }

        # Create the project root directory.
        New-Item -ItemType Directory -Name $name

        # Define folders to be created for various project sizes.
        $small_folders = @('bin', 'src')
        $medium_folders = @('build', 'include', 'lib')
        $large_folders = @('doc', 'spike', 'test')

        $folders = @()

        if ($small) { $folders += $small_folders }
        if ($medium) { $folders += $small_folders += $medium_folders }
        if ($large) { $folders += $small_folders += $medium_folders += $large_folders }

        # Create the folders defined above.
        $folders | ForEach-Object {
            New-Item -ItemType Directory -Name $_ -Path "${name}\"
        }
        
        # Download a C .gitignore from github and place it in the project root folder.
        Get-GitIgnore C $name
    }
}