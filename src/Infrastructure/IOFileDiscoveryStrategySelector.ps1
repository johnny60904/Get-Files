class IOFileDiscoveryStrategySelector {
    
    static [ScriptBlock] Select (
        [IOFileDiscovery] $traversalEngine
    ) {
        switch ($traversalEngine.DiscoveryRequest.DiscoveryProfile.TraversalScope) {
            ([TraversalScope]::Shallow) {
                return $traversalEngine.DiscoverCurrentLevel()
            }
            ([TraversalScope]::Recurse) {
                return $traversalEngine.DiscoverAll()
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