class DiscoveryRequestFactory {
    
    hidden static [string] $Component = 'DiscoveryRequestFactory'
    
    static [DiscoveryRequest] Map (
        [string] $directoryPath,
        [string[]] $childNames,
        [switch] $recurse,
        [string] $fileFilter,
        [switch] $depthFirst,
        [TraversalOptions] $traversalOptions
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