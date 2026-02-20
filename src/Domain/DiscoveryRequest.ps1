class DiscoveryRequest {
    
    [string] $DirectoryPath
    [string[]] $ChildNames
    [string] $FileFilter
    [TraversalOptions] $TraversalOptions
    [TraversalScope] $TraversalScope
    [TraversalStrategy] $TraversalStrategy
    
    DiscoveryRequest ( # Shallow
        [string] $directoryPath,
        [string[]] $childNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope
    ) {
        [DiscoveryRequestAssertions]::AssertDirectoryPathMeaningful($directoryPath)
        [DiscoveryRequestAssertions]::AssertFileFilterMeaningful($fileFilter)
        [DiscoveryRequestAssertions]::AssertShallowRequest($traversalScope)
        $this.DirectoryPath = $directoryPath
        $this.ChildNames = $childNames
        $this.FileFilter = $fileFilter
        $this.TraversalOptions = $traversalOptions
        $this.TraversalScope = $traversalScope
    }
    
    DiscoveryRequest ( # Recurse
        [string] $directoryPath,
        [string[]] $childNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope,
        [TraversalStrategy] $traversalStrategy
    ) {
        [DiscoveryRequestAssertions]::AssertDirectoryPathMeaningful($directoryPath)
        [DiscoveryRequestAssertions]::AssertFileFilterMeaningful($fileFilter)
        [DiscoveryRequestAssertions]::AssertRecursiveRequest($traversalScope)
        $this.DirectoryPath = $directoryPath
        $this.ChildNames = $childNames
        $this.FileFilter = $fileFilter
        $this.TraversalOptions = $traversalOptions
        $this.TraversalScope = $traversalScope
        $this.TraversalStrategy = $traversalStrategy
    }
    
}