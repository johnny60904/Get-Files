class DiscoveryProfileSelector {
    
    hidden static [string] $Component = 'DiscoveryProfileSelector'
    
    static [DiscoveryProfile] Select (
        [string[]] $excludeNames,
        [string] $fileFilter,
        [int] $maxDepthThreshold,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope,
        [TraversalStrategy] $traversalStrategy
    ) {
        switch ($traversalScope) {
            ([TraversalScope]::Shallow) {
                return [DiscoveryProfile]::CreateShallowProfile(
                    $excludeNames,
                    $fileFilter,
                    $maxDepthThreshold,
                    $traversalOptions,
                    $traversalScope
                )
            }
            ([TraversalScope]::Recurse) {
                return [DiscoveryProfile]::CreateRecursiveProfile(
                    $excludeNames,
                    $fileFilter,
                    $maxDepthThreshold,
                    $traversalOptions,
                    $traversalScope,
                    $traversalStrategy
                )
            }
            default {
                throw [System.InvalidOperationException]::new(
                    "Unknown identifier name for [TraversalScope] in Select."
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            "Unreachable code path in Select."
        )
        
    }
    
}