class DiscoveryProfile {
    
    [string[]] $ExcludeNames
    [string] $FileFilter
    [int] $MaxDepthThreshold
    [TraversalOptions] $TraversalOptions
    [TraversalScope] $TraversalScope
    [TraversalStrategy] $TraversalStrategy
    
    DiscoveryProfile ( # Shallow
        [string[]] $excludeNames,
        [string] $fileFilter,
        [int] $maxDepthThreshold,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope
    ) {
        [DiscoveryProfileAssertions]::AssertExcludeNamesAllowedAbsence($excludeNames)
        if ($excludeNames) { [DiscoveryProfileAssertions]::AssertExcludeNamesMeaningful($excludeNames) }
        [DiscoveryProfileAssertions]::AssertFileFilterMeaningful($fileFilter)
        [DiscoveryProfileAssertions]::AssertMaxDepthThresholdForShallow($maxDepthThreshold)
        [DiscoveryProfileAssertions]::AssertShallowProfile($traversalScope)
        $this.ExcludeNames = $excludeNames
        $this.FileFilter = $fileFilter
        $this.MaxDepthThreshold = $maxDepthThreshold
        $this.TraversalOptions = $traversalOptions
        $this.TraversalScope = $traversalScope
    }
    
    DiscoveryProfile ( # Recurse
        [string[]] $excludeNames,
        [string] $fileFilter,
        [int] $maxDepthThreshold,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope,
        [TraversalStrategy] $traversalStrategy
    ) {
        [DiscoveryProfileAssertions]::AssertExcludeNamesAllowedAbsence($excludeNames)
        if ($excludeNames) { [DiscoveryProfileAssertions]::AssertExcludeNamesMeaningful($excludeNames) }
        [DiscoveryProfileAssertions]::AssertFileFilterMeaningful($fileFilter)
        [DiscoveryProfileAssertions]::AssertMaxDepthThresholdForRecursive($maxDepthThreshold)
        [DiscoveryProfileAssertions]::AssertRecursiveProfile($traversalScope)
        $this.ExcludeNames = $excludeNames
        $this.FileFilter = $fileFilter
        $this.MaxDepthThreshold = $maxDepthThreshold
        $this.TraversalOptions = $traversalOptions
        $this.TraversalScope = $traversalScope
        $this.TraversalStrategy = $traversalStrategy
    }
    
    static [DiscoveryProfile] CreateShallowProfile (
        [string[]] $excludeNames,
        [string] $fileFilter,
        [int] $maxDepthThreshold,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope
    ) {
        return [DiscoveryProfile]::new(
            $excludeNames,
            $fileFilter,
            $maxDepthThreshold,
            $traversalOptions,
            $traversalScope
        )
    }
    
    static [DiscoveryProfile] CreateRecursiveProfile (
        [string[]] $excludeNames,
        [string] $fileFilter,
        [int] $maxDepthThreshold,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope,
        [TraversalStrategy] $traversalStrategy
    ) {
        return [DiscoveryProfile]::new(
            $excludeNames,
            $fileFilter,
            $maxDepthThreshold,
            $traversalOptions,
            $traversalScope,
            $traversalStrategy
        )
    }
    
}