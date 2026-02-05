#requires -Version 7.5
#requires -PSEdition Core

. "$([System.IO.Path]::Join($PSScriptRoot, 'src', 'Common', '_PreLoad.ps1'))"
. "$([System.IO.Path]::Join($PSScriptRoot, 'src', 'Domain', '_PreLoad.ps1'))"
. "$([System.IO.Path]::Join($PSScriptRoot, 'src', 'Infrastructure', '_PreLoad.ps1'))"
. "$([System.IO.Path]::Join($PSScriptRoot, 'src', 'Application', '_PreLoad.ps1'))"
. "$([System.IO.Path]::Join($PSScriptRoot, 'src', 'Public', '_PreLoad.ps1'))"

[string[]]$public = ((Get-ChildItem "$([System.IO.Path]::Join($PSScriptRoot, 'src', 'Public', 'Cmdlets'))" `
    -Recurse -Filter *.ps1) | Where-Object { -not $_.BaseName.ToString().StartsWith("_") }).BaseName
Export-ModuleMember -Function $public