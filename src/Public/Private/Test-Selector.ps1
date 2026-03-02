function Test-Selector {
    param()
    Write-Host "`n`nDirect Selector Call:`n"
    
    [string]$recurTestDir = [System.IO.Path]::GetFullPath([System.IO.Path]::Join($PSScriptRoot, '..', '..', '..', 'tests', 'data', 'RecursionStructureTest'))

    Write-Host "`n`nTest Dir:`n$($recurTestDir)`n"
    
    $trvOpts = [DiscoveryOptionsFactory]::CreateDefaultOptions()
    $profC = [DiscoveryProfile]::new(
        $null,
        "*.*",
        0,
        $trvOpts,
        [TraversalScope]::Shallow
    )
    $profR = [DiscoveryProfile]::new(
        $null,
        "*.*",
        [System.Int32]::MaxValue,
        $trvOpts,
        [TraversalScope]::Recurse,
        [TraversalStrategy]::DepthFirst
    )
    $reqC = [DiscoveryRequest]::new($recurTestDir, $profC)
    $reqR = [DiscoveryRequest]::new($recurTestDir, $profR)
    $engineC = [IOFileDiscovery]::new($reqC)
    $engineR = [IOFileDiscovery]::new($reqR)
    
    $selectorC = [IOFileDiscoveryStrategySelector]::new($engineC)
    $selectorR = [IOFileDiscoveryStrategySelector]::new($engineR)
    
    [ScriptBlock]$oprC = $selectorC.Select()
    Write-Host "`n`nCurrent Level:`n`n"
    & $oprC
    
    [ScriptBlock]$oprR = $selectorR.Select()
    Write-Host "`n`nAll Levels:`n`n"
    & $oprR
    
}