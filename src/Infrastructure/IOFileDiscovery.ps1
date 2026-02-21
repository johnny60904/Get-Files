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
        [string] $directory
    ) { 
        [string[]]$exclude_names = $this.DiscoveryRequest.ExcludeNames
        [string]$file_Filter = $this.DiscoveryRequest.FileFilter
        [TraversalOptions]$traversal_Options = $this.DiscoveryRequest.TraversalOptions
        return {
            param()
            [System.IO.EnumerationOptions]$enumOpts = [IOTraversalOptionsConverter]::ToEnumerationOptions($traversal_Options)
	        [ScriptBlock]$extractor = [IOTraversalContextExtraction]::ExtractLast
	        [IOTraversalContext]$Context = [IOTraversalContext]::new()
            [void] $Context.Nodes.AddLast($directory) # [void] -> 避免輸出 Nodes (LinkedList) 訊息到 console
	        while ($Context.Nodes.Count -gt 0) {
                [string]$node = & $extractor $Context
                [System.Collections.Generic.IEnumerable[string]]$files = [IOPathEnumeration]::EnumerateFiles(
                    $node,
                    $file_Filter,
                    $enumOpts
                )
                foreach ($file in $files) {
                    # [System.Threading.Tasks.Task]::Delay(500, ([System.Threading.CancellationTokenSource]::new()).Token).Wait() # for 測試是否真 lazy 用
                    [string]$fileName = [FilePath]::GetName($file)
                    if ([FileSystemNameMatcher]::MatchesAnySimpleExpression(
                        $fileName,
                        $exclude_names,
                        [FileSystemSimpleExpressionCaseSensitivity]::DefaultCaseInsensitive
                    )) { continue }
                    $file # 直接 emit, 不收集
                }
            }
        }.GetNewClosure()
    }
    
    [ScriptBlock] DiscoverAll (
        [string] $directory
    ) {
        [string[]]$exclude_names = $this.DiscoveryRequest.ExcludeNames
        [string]$file_Filter = $this.DiscoveryRequest.FileFilter
        [string]$directory_Filter = $this.DirectoryFilter
        [TraversalStrategy]$traversal_Strategy = $this.DiscoveryRequest.TraversalStrategy
        [TraversalOptions]$traversal_Options = $this.DiscoveryRequest.TraversalOptions
        return {
            param()
            [System.IO.EnumerationOptions]$enumOpts = [IOTraversalOptionsConverter]::ToEnumerationOptions($traversal_Options)
	        [ScriptBlock]$extractor = [IOTraversalContextExtractionDispatcher]::Dispatch($traversal_Strategy)
	        [IOTraversalContext]$Context = [IOTraversalContext]::new()
            [void] $Context.Nodes.AddLast($directory) # [void] -> 避免輸出 Nodes (LinkedList) 訊息到 console
	        while ($Context.Nodes.Count -gt 0) {
                [string]$node = & $extractor $Context
                [System.Collections.Generic.IEnumerable[string]]$files = [IOPathEnumeration]::EnumerateFiles(
                    $node,
                    $file_Filter,
                    $enumOpts
                )
                foreach ($file in $files) {
                    # [System.Threading.Tasks.Task]::Delay(500, ([System.Threading.CancellationTokenSource]::new()).Token).Wait() # for 測試是否真 lazy 用
                    [string]$fileName = [FilePath]::GetName($file)
                    if ([FileSystemNameMatcher]::MatchesAnySimpleExpression(
                        $fileName,
                        $exclude_names,
                        [FileSystemSimpleExpressionCaseSensitivity]::DefaultCaseInsensitive
                    )) { continue }
                    $file # 直接 emit, 不收集
                }
                [System.Collections.Generic.IEnumerable[string]]$subDirs = [IOPathEnumeration]::EnumerateDirectories(
                    $node,
                    $directory_Filter,
                    $enumOpts
                )
                foreach ($subDir in $subDirs) {
                    [string]$folderName = [FileDirectory]::GetName($subDir)
                    if ([FileSystemNameMatcher]::MatchesAnySimpleExpression(
                        $folderName,
                        $exclude_names,
                        [FileSystemSimpleExpressionCaseSensitivity]::DefaultCaseInsensitive
                    )) { continue }
                    [void] $Context.Nodes.AddLast($subDir) # [void] -> 避免輸出 Nodes (LinkedList) 訊息到 console
                }
            }
        }.GetNewClosure()
    }
    
}