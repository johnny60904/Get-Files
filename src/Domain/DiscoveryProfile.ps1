class DiscoveryProfile {
    
    [string[]] $ExcludeNames
    [string] $FileFilter
    [TraversalOptions] $TraversalOptions
    [TraversalScope] $TraversalScope
    [TraversalStrategy] $TraversalStrategy
    
    DiscoveryProfile ( # Shallow
        [string[]] $excludeNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope
    ) {
        [DiscoveryProfileAssertions]::AssertExcludeNamesAllowedAbsence($excludeNames)
        if ($excludeNames) { [DiscoveryProfileAssertions]::AssertExcludeNamesMeaningful($excludeNames) }
        [DiscoveryProfileAssertions]::AssertFileFilterMeaningful($fileFilter)
        [DiscoveryProfileAssertions]::AssertShallowProfile($traversalScope)
        $this.ExcludeNames = $excludeNames
        $this.FileFilter = $fileFilter
        $this.TraversalOptions = $traversalOptions
        $this.TraversalScope = $traversalScope
    }
    
    DiscoveryProfile ( # Recurse
        [string[]] $excludeNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope,
        [TraversalStrategy] $traversalStrategy
    ) {
        [DiscoveryProfileAssertions]::AssertExcludeNamesAllowedAbsence($excludeNames)
        if ($excludeNames) { [DiscoveryProfileAssertions]::AssertExcludeNamesMeaningful($excludeNames) }
        [DiscoveryProfileAssertions]::AssertFileFilterMeaningful($fileFilter)
        [DiscoveryProfileAssertions]::AssertRecursiveProfile($traversalScope)
        $this.ExcludeNames = $excludeNames
        $this.FileFilter = $fileFilter
        $this.TraversalOptions = $traversalOptions
        $this.TraversalScope = $traversalScope
        $this.TraversalStrategy = $traversalStrategy
    }
    
    static [DiscoveryProfile] CreateShallowProfile (
        [string[]] $excludeNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope
    ) {
        return [DiscoveryProfile]::new(
            $excludeNames,
            $fileFilter,
            $traversalOptions,
            $traversalScope
        )
    }
    
    static [DiscoveryProfile] CreateRecursiveProfile (
        [string[]] $excludeNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope,
        [TraversalStrategy] $traversalStrategy
    ) {
        return [DiscoveryProfile]::new(
            $excludeNames,
            $fileFilter,
            $traversalOptions,
            $traversalScope,
            $traversalStrategy
        )
    }
    
}