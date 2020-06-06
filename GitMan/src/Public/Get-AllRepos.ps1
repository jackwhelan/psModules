<#
 .Synopsis
  Clone all of a user's Git repositories.

 .Description
  Clone all GitHub Repositories for a specified user. Currently assumes less than 100 public repositories.

 .Parameter user
  The user from which you wish to clone all repositories from.

 .Example
   # Clone all of jackwhelan's repos on GitHub.
   Get-AllRepos jackwhelan
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
		ForEach-Object { $_.clone_url } |
        ForEach-Object { & git clone $_ 2>&1 } |
        ForEach-Object { $_.ToString() }
    }
}