class DiscoveryRequestMapper {
    
    hidden static [string] $Component = 'DiscoveryRequestMapper'
    
    static [DiscoveryRequest] Map (
        [string] $path,
        [string[]] $filterNames,
        [string] $filter,
        [TraversalOptions] $traversalOptions,
        [bool] $recurse,
        [bool] $depthFirst
    ) {
        [TraversalDepthStrategy]$traversalDepthStrategy = [TraversalPolicyAssembler]::ResolveDepthStrategy($recurse)
        [TraversalStrategy]$traversalStrategy = [TraversalPolicyAssembler]::ResolveStrategy($depthFirst)
        return [DiscoveryRequest]::new(
            $path,
            $filterNames,
            $filter,
            $traversalOptions,
            $traversalDepthStrategy,
            $traversalStrategy
        )
    }
    
}