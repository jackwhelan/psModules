<#
 .Synopsis
  Builds a project folder.

 .Description
  Builds all java source files in the directory this cmdlet is executed. (And in all subfolders if -r switch is used.

 .Parameter Recursive
 If this parameter is used, all subfolders source files are also compiled.

 .Example
   # Build a folder.
   Invoke-Build

 .Example
   # Build a folder and all subfolders.
   Invoke-Build -Recursive
#>

Function Invoke-Build {
    [CmdletBinding()]
    param(
        [Switch] $Recursive
    )

    $root = Get-ChildItem | ?{$_.PSIsContainer}

    if(Test-Path bin) {
        Write-Host "Bin folder already exists, Skipping..."
    }
    else {
        Write-Host "Creating bin folder..."
        New-Item -ItemType Directory -Path "bin"
    }

    ForEach($folder in $root) {
        if ($folder -ne "bin") {
            Write-Host "====================`nEntering $($folder)...`n===================="
            Set-Location $folder

            Write-Host "Building java files in bin folder..."
            javac -d "../bin" *.java

            Write-Host "Exiting $($folder)...`n====================`n`n`n"
            Set-Location ..
        }
    }
}

