class TraversalStrategyNormalizer {
    
    hidden static [string] $Component = 'TraversalStrategyNormalizer'
    
    static [string] NormalizeStrategyToken (
        [string] $traversalStrategyToken
    ) {
        switch ($traversalStrategyToken) {
            'Depth' { return 'DepthFirst' }
            'Breadth' { return 'BreadthFirst' }
            default {
                [ApplicationParameter]$semanticIdentity = [ApplicationParameter]::TraversalStrategy
                [string]$semanticName = $semanticIdentity.ToString()
                throw [UseCaseNormalizationException]::new(
                    [TraversalStrategyNormalizer]::Component, # ComponentName
                    [ApplicationExceptionContext]::TranslateSemanticTokenToDomainValue, # Context
                    [ApplicationExceptionReason]::TranslationFailure, # Reason
                    $semanticIdentity, # FieldName
                    $traversalStrategyToken, # TargetObject
                    "$($semanticName) is not a valid domain-supported value: '$($traversalStrategyToken)'." # Message
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            "Unreachable code path in NormalizeStrategyToken."
        )
    }
    
}