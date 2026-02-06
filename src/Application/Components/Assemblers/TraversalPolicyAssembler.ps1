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
    
    static [TraversalScope] ResolveScope (
        [bool] $recurse
    ) {
        if ($recurse) {
            return [TraversalScope]::Recurse
        } else {
            return [TraversalScope]::Shallow
        }
    }
    
}