class IOFileDiscoveryStrategySelector {
    
    static [ScriptBlock] Select (
        [System.Collections.Generic.IEnumerable[string]] $directoriesBatch,
        [TraversalScope] $traversalScope,
        [IOFileDiscovery] $ioFileDiscovery
    ) {
        switch ($traversalScope) {
            ([TraversalScope]::Shallow) {
                return $ioFileDiscovery.DiscoverCurrentLevel($directoriesBatch)
            }
            ([TraversalScope]::Recurse) {
                return $ioFileDiscovery.DiscoverAll($directoriesBatch)
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