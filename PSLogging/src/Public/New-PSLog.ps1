Function New-PSLog
{
    [CmdletBinding()]
    Param(
		[String] $LogName,
		[Switch] $IncludeWarnings,
		[Switch] $IncludeErrors
	)
	
	Begin {
		Write-Host "Logging current session in log $LogName"
		if ($IncludeWarnings) {
			Write-Host "Including Warnings."
		}
		if ($IncludeErrors) {
			Write-Host "Including Warnings."
		}
	}
	
	Process {
	}
	
	End {
	}
}
