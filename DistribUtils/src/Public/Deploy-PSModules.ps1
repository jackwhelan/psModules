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
			if(Test-Path "$($_)")
			{
				Write-Verbose "Module folder $($_) detected: Continuing..."
			}
			else
			{
				Write-Verbose "Module folder $($_) does not exist: Creating..."
				New-Item -ItemType directory "$($_)"
			}
			
			Write-Verbose "Entering $($_)"
			Set-Location "$($_)"

            if(Test-Path "psModules")
            {
                Write-Verbose "Old repository folder detected: Removing..."
                Remove-Item "psModules" -Recurse -Force
            }

			Write-Verbose "Cloning latest psModules repository..."
			git clone http://github.com/jackwhelan/psModules.git
			
			Write-Verbose "Entering Repository Folder..."
			Set-Location psModules
			
			Write-Verbose "Enumerating Modules in Repository..."
			Get-ChildItem |
			Where {$_.PsIsContainer} |
			ForEach {
				if(Test-Path "../$($_)")
				{
					Write-Verbose "Old Module folder detected, removing..."
					Remove-Item "../$($_)" -Recurse -Force
				}
				Write-Verbose "Installing New Module folder..."
				Move-Item "$($_)" ".." 
			}
		}
	}
	
	End{
	}
}