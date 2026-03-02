function Test-UseCase {
    param()
    Write-Host "`n`nDirect UseCase Call:`n"
    
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
    
    $useCaseC = [DiscoverStructuredFilesSet]::new($selectorC)
    
    $useCaseR = [DiscoverStructuredFilesSet]::new($selectorR)
    
    Write-Host "`n`nCurrent Level:`n`n"
    & $useCaseC.Execute()
    
    Write-Host "`n`nAll Levels:`n`n"
    & $useCaseR.Execute()
}