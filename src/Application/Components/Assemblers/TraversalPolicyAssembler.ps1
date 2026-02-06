class TraversalPolicyAssembler {
    
    static [TraversalStrategy] ResolveStrategy (
        [bool] $depthFirst
    ) {
        if ($depthFirst) {
            return [TraversalStrategy]::DepthFirst
        } else {
            return [TraversalStrategy]::BreadthFirst
        }
    }
    
    static [TraversalDepthStrategy] ResolveDepthStrategy (
        [bool] $recurse
    ) {
        if ($recurse) {
            return [TraversalDepthStrategy]::Infinity
        } else {
            return [TraversalDepthStrategy]::CurrentLevelOnly
        }
    }
    
}