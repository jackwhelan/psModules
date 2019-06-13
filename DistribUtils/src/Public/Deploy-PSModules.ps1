Function Deploy-PSModules
{
    [CmdletBinding()]
    param()
	
	Begin
	{
		$ModDirs = $ENV:PSModulePath -Split ";"
	}
	
	Process
	{
		$ModDirs | ForEach-Object -Process {
			if(Test-Path $_.FullName)
			{
				Write-Verbose "Module folder $_.FullName detected: Continuing..."
			}
			else
			{
				Write-Verbose "Module folder $_.FullName does not exist: Creating..."
				New-Item -folder "$_.FullName"
			}
			
			Write-Verbose "Entering $_.FullName"
			Set-Location "$_"
			
			Write-Verbose "Cloning latest psModules repository..."
			git clone http://github.com/jackwhelan/psModules.git
			
			Write-Verbose "Entering Repository Folder..."
			Set-Location psModules
			
			Write-Verbose "Enumerating Modules in Repository..."
			Get-ChildItem |
			Where {$_.PsIsContainer} |
			ForEach {
				if(Test-Path "../$_")
				{
					Write-Verbose "Old Module folder detected, removing..."
					Remove-Item "../$_"
				}
				Write-Verbose "Installing New Module folder..."
				Move-Item "$_" ".." 
			}
		}
	}
	
	End{
	}
}
