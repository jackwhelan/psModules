<#
 .Synopsis
  Return a list of branches.

 .Description
  Returns a list of branches from the current repo. Allows the user to specify whether or not they want to return remote, local or all branches.
  
 .Parameter remote
  Request remote branches.

 .Parameter local
  Request local branches.

 .Parameter all
  Request all branches.

 .Example
   # Request a list of all local branches.
   Get-Branches -local

 .Example
   # Request a list of all remote branches.
   Get-Branches -remote

 .Example
   # Request a list of all branches, both remote and local.
   Get-Branches -all
#>

Function Get-Branches
{
    [CmdletBinding()]
    param
    (
        [Switch] $remote,
		[Switch] $local,
		[Switch] $all
    )

    if ( ($remote -eq $true) -And ($local -eq $false) -And ($all -eq $false) )
	{
		git branch --list -r
	}
	elseif ( ($remote -eq $false) -And ($local -eq $true) -And ($all -eq $false) )
	{
		git branch --list
	}
	elseif ( ($remote -eq $false) -And ($local -eq $false) -And ($all -eq $true) )
	{
		git branch --list -a
	}
	else
	{
		Write-Host "Choose either -remote, -local or -all as an argument."
		Write-Host "e.g. Get-Branches -remote"
		Write-Host "This will return all remote branches."
	}
}