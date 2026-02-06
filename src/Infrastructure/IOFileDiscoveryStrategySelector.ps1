class IOFileDiscoveryStrategySelector {
    
    static [string[]] Select (
        [string[]] $directoriesBatch,
        [TraversalScope] $traversalScope,
        [IOFileDiscovery] $ioFileDiscovery
    ) {
        switch ($traversalScope) {
            Shallow {
                return ($ioFileDiscovery.DiscoverCurrentLevel($directoriesBatch))
            }
            Recurse {
                return ($ioFileDiscovery.DiscoverAll($directoriesBatch))
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