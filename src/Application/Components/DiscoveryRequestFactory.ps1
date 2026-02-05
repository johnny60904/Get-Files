class DiscoveryRequestFactory {
    
    hidden static [string] $Component = 'DiscoveryRequestFactory'
    
    static [DiscoveryRequest] Map (
        [string] $directoryPath,
        [string[]] $childNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [switch] $recurse,
        [switch] $depthFirst
    ) {
        [TraversalDepthStrategy]$traversalDepthStrategy = [DiscoveryRequestParser]::ParseTraversalDepthStrategy(
            $recurse,
            [TraversalDepthStrategyComparison]::Comparison
        ) # ParsingException
        [TraversalStrategy]$traversalStrategy = [DiscoveryRequestParser]::ParseTraversalStrategy(
            $depthFirst,
            [TraversalStrategyComparison]::Comparison
        ) # ParsingException
        return [DiscoveryRequest]::new(
            $directoryPath,
            $childNames,
            $traversalStrategy,
            $fileFilter,
            $traversalDepthStrategy,
            $traversalOptions
        )
    }
    
}