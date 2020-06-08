<#
 .Synopsis
  Downloads a .gitignore template from GitHub

 .Description
  Downloads a .gitignore template from GitHub, expects parameter for a template name .e.g `Get-GitIgnore VisualStudio`, so if we have
  a template VisualStudio.gitignore we should just provide VisualStudio and Get-GitIgnore function will create a .gitignore
  file in active folder.
  This script is originally from Senad Meškin @ https://github.com/senad-meskin/powerscripts
  Improved, modified and refactored by Jack Whelan @ https://github.com/jackwhelan/psmodules

 .Parameter templateName
  Parameter templateName is mandatory and it represents template name on the Github gitignore repository.

 .Example
  # Download VisualStudio.gitignore template
  Get-GitIgnore VisualStudio
#>

Function Get-GitIgnore {
    [CmdletBinding()]
    param(
        [Parameter(mandatory = $true)]
        [string] $template,
        [string] $path = "."
    )
	
    Process {
        # Build URL with template parameter
        $url = "https://raw.githubusercontent.com/github/gitignore/master/$($template).gitignore"
        Write-Verbose "Building URL for $($template) .gitignore"
        
        try {
            Write-Verbose "Downloading the $($template) .gitignore."
            # Download the template using the previously built URL
            Invoke-WebRequest $url -ErrorAction SilentlyContinue | Select-Object -Expand Content | Set-Content "$($path)\.gitignore" -Force
        }
        catch {
            Write-Host "There was an error while downloading the $($template) .gitignore template from GitHub, please ensure the template name is correct. (It's case sensitive)" -ForegroundColor Red
        }
    }
}