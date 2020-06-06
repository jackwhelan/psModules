<#
 .Synopsis
  Git fetcher

 .Description
  Call a git fetch in the current folder or in all subfolders if -recursive arg used.

 .Parameter recursive
  Check all subdirectories for repos and call a git fetch in each.

 .Example
   # Call git fetch in the current repo.
   Invoke-Fetch

 .Example
   # Call a git fetch in all subdirectory repos.
   Invoke-Fetch -r
#>

Function Invoke-Fetch
{
    [CmdletBinding()]
    param(
        [switch] $recursive
    )
	
	$current = (Get-Location).Path
	if (Test-Path ".git") {
		Write-Host "$current is a git repository, fetching..."
		git fetch
	}
	else {
		Write-Host "$current is not a git repository, skipping..."
	}

	if ($recursive) {
		$dir = Get-ChildItem | Where-Object {$_.PSIsContainer}
		Write-Host "Recursive switch specified, checking subdirectories..."
		New-LineBreak -l 60 -s "="
		$dir | Foreach-Object {
			Set-Location $_.FullName
			if (Test-Path ".git") {
				Write-Host "$_ is a git repository, fetching..."
				git fetch
				New-LineBreak -l 60 -s "="
			} else {
				Write-Host "$_ is not a git repository, skipping..."
			}
        }
        
        Set-Location ..
	}
}