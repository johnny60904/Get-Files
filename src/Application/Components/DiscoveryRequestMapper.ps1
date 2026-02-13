class DiscoveryRequestMapper {
    
    hidden static [string] $Component = 'DiscoveryRequestMapper'
    
    static [DiscoveryRequest] Map (
        [string] $directoryPath,
        [string[]] $childNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [bool] $recurseSubdirectories,
        [bool] $depthFirst
    ) {
        [TraversalScope]$traversalScope = [TraversalPolicyAssembler]::ResolveScope($recurseSubdirectories)
        [TraversalStrategy]$traversalStrategy = [TraversalPolicyAssembler]::ResolveStrategy($depthFirst)
        return [DiscoveryRequest]::new(
            $directoryPath,
            $childNames,
            $fileFilter,
            $traversalOptions,
            $traversalScope,
            $traversalStrategy
        )
    }
    
}