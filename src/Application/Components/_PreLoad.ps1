. "$([System.IO.Path]::Join($PSScriptRoot, 'Comparisons', '_PreLoad.ps1'))"
. "$([System.IO.Path]::Join($PSScriptRoot, 'Assemblers', '_PreLoad.ps1'))"

. "$([System.IO.Path]::Join($PSScriptRoot, 'DiscoveryOptionsFactory.ps1'))"
. "$([System.IO.Path]::Join($PSScriptRoot, 'DiscoveryOptionsParser.ps1'))"
. "$([System.IO.Path]::Join($PSScriptRoot, 'DiscoveryOptionsMapper.ps1'))"
. "$([System.IO.Path]::Join($PSScriptRoot, 'DiscoveryRequestMapper.ps1'))"