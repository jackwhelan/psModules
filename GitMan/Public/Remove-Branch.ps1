<#
 .Synopsis
  Deletes a branch.

 .Description
  Deletes a user specified branch, and the origin branch if the user uses the -origin switch parameter.

 .Parameter name
  The name of the new branch.
  
 .Parameter origin
  If the user uses this parameter the origin branch will be deleted as well as the local one.
  
 .Example
  # Delete the local branch 'feature/logo'
  Remove-Branch feature/logo
  
 .Example
  # Delete the local and origin branch 'feature/logo'
  
#>

Function New-Branch
{
    [CmdletBinding()]
    param
    (
		[Parameter(mandatory=$true)]
        [string] $name,
		[switch] $origin
    )

	git branch -d $name
	Write-Host "Local branch $($name) deleted."
	
	if ($origin)
	{
		git push --delete origin $name
		Write-Host "Origin branch $($name) deleted."
	}
}