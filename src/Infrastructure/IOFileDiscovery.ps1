class IOFileDiscovery {
    
    [TraversalStrategy] $TraversalStrategy
    [string] $FileFilter
    [string] $DirectoryFilter
    [TraversalOptions] $TraversalOptions
    
    IOFileDiscovery (
        [TraversalStrategy] $traversalStrategy,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions
    ) {
        $this.TraversalStrategy = $traversalStrategy
        $this.FileFilter = $fileFilter
        $this.DirectoryFilter = [DirectorySearchPatterns]::MatchAll
        $this.TraversalOptions = $traversalOptions
    }
    
    [string[]] DiscoverCurrentLevel (
        [string[]] $directoriesBatch
    ) {
        [System.IO.EnumerationOptions]$enumOpts = [IOTraversalOptionsConverter]::ToEnumerationOptions(
            $this.TraversalOptions
        )
        $discovered = [System.Collections.Generic.List[string]]::new()
        for ($i = 0; $i -lt $directoriesBatch.Length; $i ++) {
            [string[]]$files = [IOPathEnumeration]::EnumerateFiles(
                $directoriesBatch[$i],
                $this.FileFilter,
                $enumOpts
            )
            for ($p = 0; $p -lt $files.Length; $p ++) {
                $discovered.Add($files[$p])
            }
        }
        return $discovered.ToArray()
    }
    
    [string[]] DiscoverThoroughly (
        [string[]] $directoriesBatch
    ) {
        [System.IO.EnumerationOptions]$enumOpts = [IOTraversalOptionsConverter]::ToEnumerationOptions(
            $this.TraversalOptions
        )
        $discovered = [System.Collections.Generic.List[string]]::new()
        [ScriptBlock]$extractor = [IOTraversalContextExtractionDispatcher]::Dispatch($this.TraversalStrategy)
        [IOTraversalContext]$Context = [IOTraversalContext]::new()
        for ($i = 0; $i -lt $directoriesBatch.Length; $i ++) {
            $Context.Nodes.AddLast($directoriesBatch[$i])
        }
        while ($Context.Nodes.Count -gt 0) {
            [string]$node = & $extractor $Context
            [string[]]$files = [IOPathEnumeration]::EnumerateFiles(
                $node,
                $this.FileFilter,
                $enumOpts
            )
            for ($i = 0; $i -lt $files.Length; $i ++) {
                $discovered.Add($files[$i])
            }
            [string[]]$subDirs = [IOPathEnumeration]::EnumerateDirectories(
                $node,
                $this.DirectoryFilter,
                $enumOpts
            )
            if ($subDirs.Length -eq 0) { continue }
            for ($i = 0; $i -lt $subDirs.Length; $i ++) {
                $Context.Nodes.AddLast($subDirs[$i])
            }
        }
        return $discovered.ToArray()
    }
    
}