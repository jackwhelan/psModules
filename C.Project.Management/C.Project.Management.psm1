$Public = "$($PSScriptRoot)\src\Public"
$Private = "$($PSScriptRoot)\src\Private"

Get-ChildItem $Private -Recurse -Include *.ps1 | ForEach-Object {
    . $_.FullName
}

Get-ChildItem $Public -Recurse -Include *.ps1 | ForEach-Object {
    . $_.FullName
    ([System.Management.Automation.Language.Parser]::ParseInput((Get-Content -Path $_.FullName -Raw), [ref]$null, [ref]$null)).FindAll( { $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false) | ForEach-Object {
        Export-ModuleMember $_.Name
    }
}