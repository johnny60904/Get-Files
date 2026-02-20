function Test-Selector {
    param()
    Write-Host "`n`nDirect Selector Call:`n"
    
    [string]$recurTestDirO = [System.IO.Path]::GetFullPath([System.IO.Path]::Join($PSScriptRoot, '..', '..', '..', 'tests', 'data', 'RecursionStructureTest'))
    [string[]]$recurTestDir = [System.IO.Path]::GetFullPath([System.IO.Path]::Join($PSScriptRoot, '..', '..', '..', 'tests', 'data', 'RecursionStructureTest'))

    Write-Host "`n`nTest Dir:`n$($recurTestDir)`n"
    
    $trvOpts = [DiscoveryOptionsFactory]::CreateDefaultOptions()
    $reqC = [DiscoveryRequest]::new(
        $recurTestDirO,
        $null,
        "*.*",
        $trvOpts,
        [TraversalScope]::Shallow
    )
    $reqR = [DiscoveryRequest]::new(
        $recurTestDirO,
        $null,
        "*.*",
        $trvOpts,
        [TraversalScope]::Recurse,
        [TraversalStrategy]::DepthFirst
    )
    $engineC = [IOFileDiscovery]::new($reqC)
    $engineR = [IOFileDiscovery]::new($reqR)
    
    [ScriptBlock]$oprC = [IOFileDiscoveryStrategySelector]::Select(
        $recurTestDir,
        $engineC
    )
    Write-Host "`n`nCurrent Level:`n`n"
    & $oprC
    
    [ScriptBlock]$oprR = [IOFileDiscoveryStrategySelector]::Select(
        $recurTestDir,
        $engineR
    )
    Write-Host "`n`nAll Levels:`n`n"
    & $oprR
    
}