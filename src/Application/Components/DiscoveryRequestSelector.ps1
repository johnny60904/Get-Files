class DiscoveryRequestSelector {
    
    hidden static [string] $Component = 'DiscoveryRequestSelector'
    
    static [DiscoveryRequest] Select (
        [string] $directoryPath,
        [string[]] $excludeNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope,
        [TraversalStrategy] $traversalStrategy
    ) {
        switch ($traversalScope) {
            ([TraversalScope]::Shallow) {
                return [DiscoveryRequest]::new(
                    $directoryPath,
                    $excludeNames,
                    $fileFilter,
                    $traversalOptions,
                    $traversalScope
                )
            }
            ([TraversalScope]::Recurse) {
                return [DiscoveryRequest]::new(
                    $directoryPath,
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