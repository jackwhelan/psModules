<#
 .Synopsis
  Git status checker.

 .Description
  Check the git status of a repo or all sub-folder repos if you specify.

 .Parameter recursive
  Check all subdirectories for repos and return their status.

 .Example
   # Check the status of the current repo.
   Invoke-StatusCheck

 .Example
   # Check the status of all subdirectory repos.
   Invoke-StatusCheck -r
#>

Function Invoke-StatusCheck
{
    [CmdletBinding()]
    param(
        [switch] $recursive
    )
	
	$current = (Get-Location).Path
	if (Test-Path ".git") {
		Write-Host "$current is a git repository, checking status..."
		git status
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
				Write-Host "$_ is a git repository, checking status..."
				git status
				New-LineBreak -l 60 -s "="
			} else {
				Write-Host "$_ is not a git repository, skipping..."
			}
		}
	}
}