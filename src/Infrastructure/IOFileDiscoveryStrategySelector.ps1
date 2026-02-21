class IOFileDiscoveryStrategySelector {
    
    static [ScriptBlock] Select (
        [string] $directory,
        [IOFileDiscovery] $traversalEngine
    ) {
        switch ($traversalEngine.DiscoveryRequest.TraversalScope) {
            ([TraversalScope]::Shallow) {
                return $traversalEngine.DiscoverCurrentLevel($directory)
            }
            ([TraversalScope]::Recurse) {
                return $traversalEngine.DiscoverAll($directory)
            }
            default {
                throw [System.InvalidOperationException]::new(
                    'Unknown identifier name for [TraversalScope] in Select.'
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in Select.'
        )
    }
    
}