Function Repair-JavaBuildUtils
{
    [CmdletBinding()]
    Param()

    Begin {
        Write-Verbose "Locating Module Folders..."
        $ModDirs = $ENV:PSModulePath -Split ";"
    }

    Process {   
        If (Test-Path "$ENV:HomeDrive/Program Files") {
            Set-Location "$ENV:HomeDrive/Program Files"
            If (Test-Path "JackWhelan") {
                Write-Verbose "JackWhelan directory located..."
            } Else {
                Write-Verbose "Creating JackWhelan directory..."
                New-Item -ItemType directory "JackWhelan"
            }
        } Else {
            Set-Location "$ENV:HomeDrive\Program Files (x86)"
            If (Test-Path "JackWhelan") {
                Write-Verbose "JackWhelan directory located..."
            } Else {
                Write-Verbose "Creating JackWhelan directory..."
                New-Item -ItemType directory "JackWhelan"
            }
        }

        Set-Location "JackWhelan"
        if(Test-Path "psModules") {
            Write-Verbose "Old repository folder detected: Removing..."
            Remove-Item "psModules" -Recurse -Force
        }

        Write-Verbose "Cloning latest psModules repository..."
	    git clone http://github.com/jackwhelan/psModules.git

		Write-Verbose "Entering Repository Folder..."
		Set-Location psModules

        $ModDirs | ForEach-Object -Process {
		    if(Test-Path "$($_)") {
				Write-Verbose "Module folder $($_) detected: Continuing..."
			} else {
			    Write-Verbose "Module folder $($_) does not exist: Creating..."
			    New-Item -ItemType directory "$($_)"
		    }
               
            Write-Verbose "Checking for old JavaBuildUtils module in $($_)..."
            If(Test-Path "$($_)/JavaBuildUtils") {
                Write-Verbose "Old module found, removing..."
                Remove-Item "$($_)/JavaBuildUtils" -Recurse -Force
            }

            Write-Verbose "Installing JavaBuildUtils module in $($_)..."
            Copy-Item "JavaBuildUtils" "$($_)"
        }
    }

    End {
        Write-Verbose "DONE."
    }
}