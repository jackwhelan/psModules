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

Function Invoke-Build
{
    [CmdletBinding()]
    param
    (
        [Switch] $Recursive
    )

    git clone "$($server)/$($user)/$($repo)"
}

$root = Get-ChildItem | ?{$_.PSIsContainer}

ForEach($folder in $root)
{
    Write-Host "====================`nEntering $($folder)...`n===================="
    cd $folder

    Write-Host "Creating bin folder..."
    if(Test-Path bin)
    {
        Write-Host "Bin folder already exists for $($folder), Skipping..."
    }
    else
    {
        mkdir bin
    }

    Write-Host "Building java files in bin folder..."
    javac -d "bin" *.java

    Write-Host "Exiting $($folder)...`n====================`n`n`n"
    cd ..
}