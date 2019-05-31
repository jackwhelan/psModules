<#
 .Synopsis
  Clone a Repo.

 .Description
  Clone a specific git repo from a server using user provided repo name, username and server.

 .Parameter repo
  The repo to clone.

 .Parameter user
  The user the repo belongs to.

 .Parameter server
  The server the repo is stored on.

 .Example
   # Clone the Portfolio repo (using default server[github] and user[jackwhelan] values)
   Get-Repo Portfolio

 .Example
   # Clone a specific repo using a specificied user.
   Get-Repo hello-world-java leereilly

 .Example
   # Clone a specific repo using a specified user and a specified server.
   Get-Repo helloword atlassian_tutorial https://bitbucket.org
#>

Function Get-Repo
{
    [CmdletBinding()]
    param
    (
        [string] $repo = "psModules",
        [string] $user = "jackwhelan",
        [string] $server = "http://github.com"
    )

    git clone "$($server)/$($user)/$($repo)"
}