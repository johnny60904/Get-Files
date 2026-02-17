#requires -Version 7.5
#requires -PSEdition Core

. "$PSScriptRoot/src/Common/_PreLoad.ps1"
. "$PSScriptRoot/src/Domain/_PreLoad.ps1"
. "$PSScriptRoot/src/Infrastructure/_PreLoad.ps1"
. "$PSScriptRoot/src/Application/_PreLoad.ps1"
. "$PSScriptRoot/src/Public/_PreLoad.ps1"

$public = (Get-ChildItem "$PSScriptRoot/src/Public/Cmdlets" -Recurse -Filter *.ps1 `
    | Where-Object { -not $_.BaseName.ToString().StartsWith("_") }).BaseName
Export-ModuleMember -Function $public