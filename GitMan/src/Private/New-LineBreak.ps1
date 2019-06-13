<#
 .Synopsis
  Draws a line to break up console output.

 .Description
  Creates a line break using "=".

 .Parameter length
  The Length of the line in characters.
  
 .Parameter symbol
  The Character of the line.
  
 .Example
  # Insert a line like this: ==========
  New-LineBreak -length 10 -symbol "="
#>

Function New-LineBreak
{
    [CmdletBinding()]
    param
    (
		[int] $length,
		[string] $symbol
    )
	
	Begin
	{
		$line = ""
	}
	
	Process
	{
		For ($i = 0; $i -lt $length; $i++)
		{
			$line = "$($line)$symbol"
		}
		
		Write-Host $line
	}
	
	End{
	}
}