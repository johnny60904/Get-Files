class DiscoveryProfileSelector {
    
    hidden static [string] $Component = 'DiscoveryProfileSelector'
    
    static [DiscoveryProfile] Select (
        [string[]] $excludeNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope,
        [TraversalStrategy] $traversalStrategy
    ) {
        switch ($traversalScope) {
            ([TraversalScope]::Shallow) {
                return [DiscoveryProfile]::new(
                    $excludeNames,
                    $fileFilter,
                    $traversalOptions,
                    $traversalScope
                )
            }
            ([TraversalScope]::Recurse) {
                return [DiscoveryProfile]::new(
                    $excludeNames,
                    $fileFilter,
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