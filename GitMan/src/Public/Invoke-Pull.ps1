<#
 .Synopsis
  Git puller

 .Description
  Pull the latest commits of a repo or all sub-folder repos if you specify -recursive.

 .Parameter recursive
  Check all subdirectories for repos and pull their latest code.

 .Example
   # Call a git pull in the current repo.
   Invoke-Pull

 .Example
   # Call a git pull in all subdirectory repos.
   Invoke-Pull -r
#>

Function Invoke-Pull
{
    [CmdletBinding()]
    param(
        [switch] $recursive
    )
	
	$current = (Get-Location).Path
	if (Test-Path ".git") {
		Write-Host "$current is a git repository, pulling latest..."
		git pull
	}
	else {
		Write-Host "$current is not a git repository, skipping..."
	}

	if ($recursive) {
		$dir = Get-ChildItem | ? {$_.PSIsContainer}
		Write-Host "Recursive switch specified, checking subdirectories..."
		New-LineBreak -l 60 -s "="
		$dir | Foreach-Object {
			Set-Location $_.FullName
			if (Test-Path ".git") {
				Write-Host "$_ is a git repository, pulling latest..."
				git pull
				New-LineBreak -l 60 -s "="
			} else {
				Write-Host "$_ is not a git repository, skipping..."
			}
		}
    }
    
    Set-Location ..
}