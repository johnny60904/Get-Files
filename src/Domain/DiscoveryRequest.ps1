class DiscoveryRequest {
    
    [string] $DirectoryPath
    [string[]] $ChildNames
    [string] $FileFilter
    [TraversalOptions] $TraversalOptions
    [TraversalScope] $TraversalScope
    [TraversalStrategy] $TraversalStrategy
    
    DiscoveryRequest (
        [string] $directoryPath,
        [string[]] $childNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope,
        [TraversalStrategy] $traversalStrategy
    ) {
        $this.DirectoryPath = $directoryPath
        $this.ChildNames = $childNames
        $this.FileFilter = $fileFilter
        $this.TraversalOptions = $traversalOptions
        $this.TraversalScope = $traversalScope
        $this.TraversalStrategy = $traversalStrategy
    }
    
}