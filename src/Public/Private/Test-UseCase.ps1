function Test-UseCase {
    param()
    Write-Host "`n`nDirect UseCase Call:`n"
    
    [string[]]$recurTestDir = [System.IO.Path]::GetFullPath([System.IO.Path]::Join($PSScriptRoot, '..', '..', '..', 'tests', 'data', 'RecursionStructureTest'))

    Write-Host "`n`nTest Dir:`n$($recurTestDir)`n"
    
    $trvOpts = [DiscoveryOptionsFactory]::CreateDefaultOptions()
    $engine = [IOFileDiscovery]::new(
        [TraversalStrategy]::DepthFirst,
        '*.*',
        $trvOpts
    )
    
    $useCaseC = [DiscoverStructuredFilesSet]::new(
        [DiscoveryRequest]::new(
            $recurTestDir,
            @(),
            '*.*',
            $trvOpts,
            [TraversalScope]::Shallow,
            [TraversalStrategy]::DepthFirst
        )
    )
    
    $useCaseR = [DiscoverStructuredFilesSet]::new(
        [DiscoveryRequest]::new(
            $recurTestDir,
            @(),
            '*.*',
            $trvOpts,
            [TraversalScope]::Recurse,
            [TraversalStrategy]::DepthFirst
        )
    )
    
    Write-Host "`n`nCurrent Level:`n`n"
    & $useCaseC.Execute()
    
    Write-Host "`n`nAll Levels:`n`n"
    & $useCaseR.Execute()
}