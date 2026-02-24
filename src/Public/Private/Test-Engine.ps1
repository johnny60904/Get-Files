function Test-Engine {
    param()
    Write-Host "`n`nDirect Engine Call:`n"
    
    [string]$recurTestDir = [System.IO.Path]::GetFullPath([System.IO.Path]::Join($PSScriptRoot, '..', '..', '..', 'tests', 'data', 'RecursionStructureTest'))

    Write-Host "`n`nTest Dir:`n$($recurTestDir)`n"
    
    $trvOpts = [DiscoveryOptionsFactory]::CreateDefaultOptions()
    $profC = [DiscoveryProfile]::new(
        $null,
        "*.*",
        $trvOpts,
        [TraversalScope]::Shallow
    )
    $profR = [DiscoveryProfile]::new(
        $null,
        "*.*",
        $trvOpts,
        [TraversalScope]::Recurse,
        [TraversalStrategy]::DepthFirst
    )
    $reqC = [DiscoveryRequest]::new($recurTestDir, $profC)
    $reqR = [DiscoveryRequest]::new($recurTestDir, $profR)
    $engineC = [IOFileDiscovery]::new($reqC)
    $engineR = [IOFileDiscovery]::new($reqR)
    
    [ScriptBlock]$oprC = $engineC.DiscoverCurrentLevel()
    Write-Host "`n`nCurrent Level:`n`n"
    & $oprC
    
    [ScriptBlock]$oprR = $engineR.DiscoverAll()
    Write-Host "`n`nAll Levels:`n`n"
    & $oprR
}