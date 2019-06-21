Function Backup-PSModules
{
    [CmdletBinding()]
    Param(
		[String] $destination = "$($ENV:HomeDrive)$($ENV:HomePath)/Desktop"
	)
	
	Begin {
		$ModDirs = $ENV:PSModulePath -Split ";"
		$modules = "Modules "
	}
	
	Process {
		$ModDirs | ForEach-Object -Process {
			Write-Verbose "Backing up module folder $($_) to $($destination)"
			
			If (-not (Test-Path "$($destination)\$($modules)")) {
				Copy-Item "$($_)" "$($destination)"
			}
			Else {
				While (Test-Path "$($destination)\$($modules)") {
					$modules = modules + "I"
				}
		}
	}
	
	End {
	}
}
