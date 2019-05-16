<#
 .Synopsis
  Makes a new branch.

 .Description
  Make a new branch within the git repo the user is currently in.

 .Parameter name
  The name of the new branch.
  
 .Example
  # Create a new feature branch for adding a logo to a website.
  New-Branch feature/website-logo
#>

Function New-Branch
{
    [CmdletBinding()]
    param
    (
		[Parameter(mandatory=$true)]
        [string] $name
    )

    git branch $name
	git checkout $name
}