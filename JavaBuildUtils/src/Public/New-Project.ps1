﻿ function New-Project() {
    [CmdletBinding()]
    Param (
        [String] $Name
    )

	Process {
		Write-Host "Creating Project Folder..."
		New-Item -ItemType Directory -Path $Name

		Write-Host "Entering Project Folder..."
		Set-Location $Name

		Write-Host "Creating src and bin folders..."
		New-Item -ItemType Directory -Path "src"
		New-Item -ItemType Directory -Path "bin"

		Write-Host "Creating Control class..."
		Set-Location src
		Invoke-WebRequest -Uri "https://www.jackwhelan.dev/snippets/Control.java" -Method GET -OutFile "Control.java"
	}
}