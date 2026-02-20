class IOFileDiscovery {
    
    [DiscoveryRequest] $DiscoveryRequest
    [string] $DirectoryFilter
    
    IOFileDiscovery (
        [DiscoveryRequest] $discoveryRequest
    ) {
        $this.DiscoveryRequest = $discoveryRequest
        $this.DirectoryFilter = [DirectorySearchPatterns]::MatchAll
    }
    
    [ScriptBlock] DiscoverCurrentLevel (
        [System.Collections.Generic.IEnumerable[string]] $directoriesBatch
    ) { 
        [string]$file_Filter = $this.DiscoveryRequest.FileFilter
        [TraversalOptions]$traversal_Options = $this.DiscoveryRequest.TraversalOptions
        return {
            param()
            [System.IO.EnumerationOptions]$enumOpts = [IOTraversalOptionsConverter]::ToEnumerationOptions($traversal_Options)
	        [ScriptBlock]$extractor = [IOTraversalContextExtraction]::ExtractLast
	        [IOTraversalContext]$Context = [IOTraversalContext]::new()
	        for ($i = 0; $i -lt $directoriesBatch.Length; $i ++) {
                [void] $Context.Nodes.AddLast($directoriesBatch[$i]) # [void] -> 避免輸出 Nodes (LinkedList) 訊息到 console
            }
	        while ($Context.Nodes.Count -gt 0) {
                [string]$node = & $extractor $Context
                [System.Collections.Generic.IEnumerable[string]]$files = [IOPathEnumeration]::EnumerateFiles(
                    $node,
                    $file_Filter,
                    $enumOpts
                )
                foreach ($file in $files) {
                    # [System.Threading.Tasks.Task]::Delay(500, ([System.Threading.CancellationTokenSource]::new()).Token).Wait() # for 測試是否真 lazy 用
                    $file # 直接 emit, 不收集
                }
            }
        }.GetNewClosure()
    }
    
    [ScriptBlock] DiscoverAll (
        [System.Collections.Generic.IEnumerable[string]] $directoriesBatch
    ) {
        [string]$file_Filter = $this.DiscoveryRequest.FileFilter
        [string]$directory_Filter = $this.DirectoryFilter
        [TraversalStrategy]$traversal_Strategy = $this.DiscoveryRequest.TraversalStrategy
        [TraversalOptions]$traversal_Options = $this.DiscoveryRequest.TraversalOptions
        return {
            param()
            [System.IO.EnumerationOptions]$enumOpts = [IOTraversalOptionsConverter]::ToEnumerationOptions($traversal_Options)
	        [ScriptBlock]$extractor = [IOTraversalContextExtractionDispatcher]::Dispatch($traversal_Strategy)
	        [IOTraversalContext]$Context = [IOTraversalContext]::new()
	        for ($i = 0; $i -lt $directoriesBatch.Length; $i ++) {
                [void] $Context.Nodes.AddLast($directoriesBatch[$i]) # [void] -> 避免輸出 Nodes (LinkedList) 訊息到 console
            }
	        while ($Context.Nodes.Count -gt 0) {
                [string]$node = & $extractor $Context
                [System.Collections.Generic.IEnumerable[string]]$files = [IOPathEnumeration]::EnumerateFiles(
                    $node,
                    $file_Filter,
                    $enumOpts
                )
                foreach ($file in $files) {
                    # [System.Threading.Tasks.Task]::Delay(500, ([System.Threading.CancellationTokenSource]::new()).Token).Wait() # for 測試是否真 lazy 用
                    $file # 直接 emit, 不收集
                }
                [System.Collections.Generic.IEnumerable[string]]$subDirs = [IOPathEnumeration]::EnumerateDirectories(
                    $node,
                    $directory_Filter,
                    $enumOpts
                )
                foreach ($subDir in $subDirs) {
                    [void] $Context.Nodes.AddLast($subDir) # [void] -> 避免輸出 Nodes (LinkedList) 訊息到 console
                }
            }
        }.GetNewClosure()
    }
    
}