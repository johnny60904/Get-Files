class IOFileDiscoveryStrategySelector {
    
    static [string[]] Select (
        [string[]] $directoriesBatch,
        [TraversalDepthStrategy] $traversalDepthStrategy,
        [IOFileDiscovery] $ioFileDiscovery
    ) {
        switch ($traversalDepthStrategy) {
            CurrentLevelOnly {
                return ($ioFileDiscovery.DiscoverCurrentLevel($directoriesBatch))
            }
            Infinity {
                return ($ioFileDiscovery.DiscoverThoroughly($directoriesBatch))
            }
            default {
                throw [System.InvalidOperationException]::new(
                    'Unknown identifier name for [TraversalDepthStrategy] in Select.'
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in Select.'
        )
    }
    
}