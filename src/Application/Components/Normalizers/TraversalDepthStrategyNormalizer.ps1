class TraversalDepthStrategyNormalizer {
    
    hidden static [string] $Component = 'TraversalDepthStrategyNormalizer'
    
    static [string] Normalize (
        [string] $value,
        [System.StringComparison] $comparison
    ) {
        if ([System.String]::Equals( # Current
                $value,
                [TraversalDepthStrategyAllowedTokens]::CurrentLevelOnlyToken,
                $comparison
            )
        ) {
            return [TraversalDepthStrategyIdentifierNames]::CurrentLevelOnlyName
        } elseif ([System.String]::Equals( # All
                $value,
                [TraversalDepthStrategyAllowedTokens]::InfinityToken,
                $comparison
            )
        ) {
            return [TraversalDepthStrategyIdentifierNames]::InfinityName
        } else {
            return $null
        }
    }
    
}