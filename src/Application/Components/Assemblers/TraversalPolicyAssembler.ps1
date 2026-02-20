class TraversalPolicyAssembler {
    
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