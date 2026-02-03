class TraversalStrategyNormalizer {
    
    hidden static [string] $Component = 'TraversalStrategyNormalizer'
    
    static [string] Normalize (
        [string] $value,
        [System.StringComparison] $comparison
    ) {
        if ([System.String]::Equals( # DFS
                $value,
                [TraversalStrategyAllowedTokens]::DepthFirstToken,
                $comparison
            )
        ) {
            return [TraversalStrategyIdentifierNames]::DepthFirstName
        } elseif ([System.String]::Equals( # BFS
                $value,
                [TraversalStrategyAllowedTokens]::BreadthFirstToken,
                $comparison
            )
        ) {
            return [TraversalStrategyIdentifierNames]::BreadthFirstName
        } else {
            return $null
        }
    }
    
}