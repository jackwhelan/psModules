﻿function New-Project()
{
    [CmdletBinding()]
    param
    (
        [String] $Name
    )

    Write-Host "Creating Project Folder..."
    New-Item -ItemType Directory -Path $Name

    Write-Host "Entering Project Folder..."
    Set-Location $Name

    Write-Host "Creating src and bin folders..."
    New-Item -ItemType Directory -Path "src"
    New-Item -ItemType Directory -Path "bin"

    Write-Host "Creating Control class..."
    Set-Location src
    Invoke-WebRequest -Uri "176.61.21.93/snippets/Control.java" -Method GET -OutFile "Control.java"
}