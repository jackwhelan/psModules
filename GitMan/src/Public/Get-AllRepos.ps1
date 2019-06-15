<#
 .Synopsis
  Clone all of a users Repos.

 .Description
  Clone all git repos from a user on a server using user provided repo name, username and server.

 .Parameter user
  The user the repo belongs to.

 .Parameter server
  The server the repo is stored on.

 .Example
   # Clone all of jackwhelan's repos on GitHub.
   Get-AllRepos jackwhelan http://github.com
#>

Function Get-AllRepos
{
    [CmdletBinding()]
	Param(
        [string] $user = "jackwhelan"
    )

	Process {
		(Invoke-WebRequest "https://api.github.com/users/$user/repos?page=1&per_page=100").Content |
		ConvertFrom-Json |
		%{ $_.clone_url } |
		%{ & git clone $_ 2>&1 } |
		%{ $_.ToString()}
	}
}