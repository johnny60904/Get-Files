class DiscoveryRequest {
    
    [string] $DirectoryPath
    [string[]] $ChildNames
    [string] $FileFilter
    [TraversalOptions] $TraversalOptions
    [TraversalDepthStrategy] $TraversalDepthStrategy
    [TraversalStrategy] $TraversalStrategy
    
    DiscoveryRequest (
        [string] $directoryPath,
        [string[]] $childNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [TraversalDepthStrategy] $traversalDepthStrategy,
        [TraversalStrategy] $traversalStrategy
    ) {
        $this.DirectoryPath = $directoryPath
        $this.ChildNames = $childNames
        $this.FileFilter = $fileFilter
        $this.TraversalOptions = $traversalOptions
        $this.TraversalDepthStrategy = $traversalDepthStrategy
        $this.TraversalStrategy = $traversalStrategy
    }
    
}