class IOFileDiscoveryStrategySelector {
    
    [IOFileDiscovery] $TraversalEngine
    
    IOFileDiscoveryStrategySelector (
        [IOFileDiscovery] $traversalEngine
    ) {
        $this.TraversalEngine = $traversalEngine
    }
    
    [ScriptBlock] Select () {
        switch ($this.TraversalEngine.DiscoveryRequest.DiscoveryProfile.TraversalScope) {
            ([TraversalScope]::Shallow) {
                return $this.TraversalEngine.DiscoverCurrentLevel()
            }
            ([TraversalScope]::Recurse) {
                return $this.TraversalEngine.DiscoverAll()
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