function Test-Selector {
    param()
    Write-Host "`n`nDirect Selector Call:`n"
    
    [string[]]$recurTestDir = [System.IO.Path]::GetFullPath([System.IO.Path]::Join($PSScriptRoot, '..', '..', '..', 'tests', 'data', 'RecursionStructureTest'))

    Write-Host "`n`nTest Dir:`n$($recurTestDir)`n"
    
    $trvOpts = [DiscoveryOptionsFactory]::CreateDefaultOptions()
    $engine = [IOFileDiscovery]::new(
        [TraversalStrategy]::DepthFirst,
        '*.*',
        $trvOpts
    )
    
    [ScriptBlock]$oprC = [IOFileDiscoveryStrategySelector]::Select(
        $recurTestDir,
        [TraversalScope]::Shallow,
        $engine
    )
    Write-Host "`n`nCurrent Level:`n`n"
    & $oprC
    
    [ScriptBlock]$oprR = [IOFileDiscoveryStrategySelector]::Select(
        $recurTestDir,
        [TraversalScope]::Recurse,
        $engine
    )
    Write-Host "`n`nAll Levels:`n`n"
    & $oprR
    
}