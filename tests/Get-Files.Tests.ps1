# using module GetFiles
. "$([System.IO.Path]::Join($PSScriptRoot, '_PreLoad.ps1'))"

[string]$ModuleRoot = [System.IO.Path]::GetFullPath([System.IO.Path]::Join($PSScriptRoot, '..')) # Split-Path -Parent $PSScriptRoot
[string]$ModulePath = [System.IO.Path]::GetFullPath([System.IO.Path]::Join($ModuleRoot, 'src', 'GetFiles.psm1')) # Join-Path $ModuleRoot 'src/Get-Files.psm1'

# 自動載入 unit / integration 測試
Get-ChildItem -Path $PSScriptRoot -Recurse -Filter '*.Tests.ps1' | 
    Where-Object { $_.FullName -ne $PSScriptRoot } | 
    ForEach-Object { . $_.FullName }