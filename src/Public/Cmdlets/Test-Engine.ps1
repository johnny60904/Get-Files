function Test-Engine {
    param()
    Write-Host "`n`nDirect Engine Call:`n"
    
    [string[]]$recurTestDir = [System.IO.Path]::GetFullPath([System.IO.Path]::Join('C:\', 'Users', 'DXjoh', 'Coding', 'practise', 'pwsh', '7.5+', 'formal', 'StructuredFilesDiscover', 'recurTest'))

    Write-Host "`n`nTest Dir:`n$($recurTestDir)`n"
    
    $trvOpts = [DiscoveryOptionsFactory]::CreateDefaultOptions()
    $engine = [IOFileDiscovery]::new(
        [TraversalStrategy]::DepthFirst,
        '*.*',
        $trvOpts
    )
    
    [ScriptBlock]$oprC = $engine.DiscoverCurrentLevel($recurTestDir)
    Write-Host "`n`nCurrent Level:`n`n"
    & $oprC
    
    [ScriptBlock]$oprR = $engine.DiscoverAll($recurTestDir)
    Write-Host "`n`nAll Levels:`n`n"
    & $oprR
}