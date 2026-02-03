class DiscoveryRequestFactory {
    
    hidden static [string] $Component = 'DiscoveryRequestFactory'
    
    static [DiscoveryRequest] MapRequest (
        [string] $directoryPath,
        [string[]] $childNames,
        [string] $traversalMode,
        [string] $fileFilter,
        [string] $recursionDepthMode,
        [TraversalOptions] $traversalOptions
    ) {
        [TraversalStrategy]$traversalStrategy = [DiscoveryRequestParser]::ParseTraversalStrategy(
            $traversalMode,
            [TraversalStrategyComparison]::Comparison
        ) # ParsingException
        [TraversalDepthStrategy]$traversalDepthStrategy = [DiscoveryRequestParser]::ParseTraversalDepthStrategy(
            $recursionDepthMode,
            [TraversalDepthStrategyComparison]::Comparison
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