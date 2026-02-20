class DiscoveryRequestParser {
    
    hidden static [string] $Component = 'DiscoveryRequestParser'
    
    static [bool] TryParseTraversalStrategy (
        [string] $traversalStrategy,
        [bool] $ignoreCase,
        [ref] $result
    ) {
        return [System.Enum]::TryParse(
            [TraversalStrategy],
            $traversalStrategy,
            $ignoreCase,
            $result
        )
    }
    
    static [TraversalStrategy] ParseTraversalStrategy (
        [string] $traversalStrategy,
        [System.StringComparison] $comparison
    ) {
        [ApplicationParameter]$semanticIdentity = [ApplicationParameter]::TraversalStrategy
        [string]$semanticName = $semanticIdentity.ToString()
        if ([System.String]::IsNullOrWhiteSpace($traversalStrategy)) {
            throw [UseCaseParsingException]::new(
                [DiscoveryRequestParser]::Component, # ComponentName
                [ApplicationExceptionContext]::AssertSemanticTokenMeaningfulness, # Context
                [ApplicationExceptionReason]::NullOrWhiteSpace, # Reason
                $semanticIdentity, # FieldName
                $traversalStrategy, # TargetObject
                "$($semanticName) must not be null, empty, or whitespace." # Message
            )
        }
        [bool]$isCaseInsensitive = [StringComparisonInspector]::IsCaseInsensitive($comparison)
        $parsed = $null
        [bool]$isValid = [DiscoveryRequestParser]::TryParseTraversalStrategy(
            $traversalStrategy,
            $isCaseInsensitive,
            [ref]$parsed
        )
        if (-not $isValid) {
            throw [UseCaseParsingException]::new(
                [DiscoveryRequestParser]::Component, # ComponentName
                [ApplicationExceptionContext]::TranslateSemanticTokenToDomainValue, # Context
                [ApplicationExceptionReason]::TranslationFailure, # Reason
                $semanticIdentity, # FieldName
                $traversalStrategy, # TargetObject
                "$($semanticName) is not a valid domain-supported value: '$($traversalStrategy)'." # Message
            )
        }
        return $parsed
    }
    
}