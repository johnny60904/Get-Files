class IOFileDiscoveryStrategySelector {
    
    static [ScriptBlock] Select (
        [System.Collections.Generic.IEnumerable[string]] $directoriesBatch,
        [IOFileDiscovery] $traversalEngine
    ) {
        switch ($traversalEngine.DiscoveryRequest.TraversalScope) {
            ([TraversalScope]::Shallow) {
                return $traversalEngine.DiscoverCurrentLevel($directoriesBatch)
            }
            ([TraversalScope]::Recurse) {
                return $traversalEngine.DiscoverAll($directoriesBatch)
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