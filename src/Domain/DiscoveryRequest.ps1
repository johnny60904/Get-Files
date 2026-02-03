class DiscoveryRequest {
    
    [string] $DirectoryPath
    [string[]] $ChildNames
    [TraversalStrategy] $TraversalStrategy
    [string] $FileFilter
    [TraversalDepthStrategy] $TraversalDepthStrategy
    [TraversalOptions] $TraversalOptions
    
    DiscoveryRequest (
        [string] $directoryPath,
        [string[]] $childNames,
        [TraversalStrategy] $traversalStrategy,
        [string] $fileFilter,
        [TraversalDepthStrategy] $traversalDepthStrategy,
        [TraversalOptions] $traversalOptions
    ) {
        $this.DirectoryPath = $directoryPath
        $this.ChildNames = $childNames
        $this.TraversalStrategy = $traversalStrategy
        $this.FileFilter = $fileFilter
        $this.TraversalDepthStrategy = $traversalDepthStrategy
        $this.TraversalOptions = $traversalOptions
    }
    
}