# using module GetFiles

# [string]$ModuleRoot = [System.IO.Path]::GetFullPath([System.IO.Path]::Join($PSScriptRoot, '..')) # Split-Path -Parent $PSScriptRoot
# [string]$ModulePath = [System.IO.Path]::GetFullPath([System.IO.Path]::Join($ModuleRoot, 'src', 'GetFiles.psm1')) # Join-Path $ModuleRoot 'src/Get-Files.psm1'

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Resolve-Path "$here\.."

$modulePath = Join-Path $repoRoot "GetFiles.psd1"

Import-Module $modulePath -Force

# 自動載入 unit / integration 測試
Get-ChildItem -Path $PSScriptRoot -Recurse -Filter '*.Tests.ps1' | 
    Where-Object { $_.FullName -ne $PSCommandPath } | 
    ForEach-Object { . $_.FullName }