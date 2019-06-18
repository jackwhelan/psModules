Function Repair-PSModules
{
    [CmdletBinding()]
    param()
	
	Begin {
		$ModDirs = $ENV:PSModulePath -Split ";"
        $Backup = ""
	}
	
	Process {
		$ModDirs | ForEach-Object -Process {
			if(Test-Path "$($_)") {
				Write-Verbose "Module folder $($_) detected: Continuing..."
			} else {
				Write-Verbose "Module folder $($_) does not exist: Creating..."
				New-Item -ItemType directory "$($_)"
			}
			
			Write-Verbose "Entering $($_)"
			Set-Location "$($_)"

			Write-Verbose "Enumerating backup modules..."
			Get-ChildItem |
			Where {$_.PsIsContainer} |
			ForEach {
				if(Test-Path "../$($_)") {
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
