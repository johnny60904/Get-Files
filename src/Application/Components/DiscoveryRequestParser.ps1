class DiscoveryRequestParser {
    
    hidden static [string] $Component = 'DiscoveryRequestParser'
    
    static [bool] TryParseTraversalStrategy (
        [string] $value,
        [bool] $ignoreCase,
        [ref] $result
    ) {
        return [System.Enum]::TryParse(
            [TraversalStrategy],
            $value,
            $ignoreCase,
            $result
        )
    }
    
    static [bool] TryParseTraversalDepthStrategy (
        [string] $value,
        [bool] $ignoreCase,
        [ref] $result
    ) {
        return [System.Enum]::TryParse(
            [TraversalDepthStrategy],
            $value,
            $ignoreCase,
            $result
        )
    }
    
    static [TraversalStrategy] ParseTraversalStrategy (
        [string] $value,
        [System.StringComparison] $comparison
    ) {
        [string]$semanticName = ([ApplicationSemanticNames]::TraversalStrategy).ToString()
        if ([System.String]::IsNullOrWhiteSpace($value)) {
            throw [UseCaseParsingException]::new(
                [DiscoveryRequestParser]::Component, # ComponentName
                ([ApplicationExceptionContext]::AssertSemanticTokenMeaningfulness).ToString(), # Context
                ([ApplicationExceptionReason]::SemanticTokenNullOrWhiteSpace).ToString(), # Reason
                "$($semanticName) must not be null, empty, or whitespace." # Message
            )
        }
        [string]$normalized = [TraversalStrategyNormalizer]::Normalize($value, $comparison)
        [bool]$isCaseInsensitive = [StringComparisonInspector]::IsCaseInsensitive($comparison)
        $parsed = $null
        [bool]$isValid = [DiscoveryRequestParser]::TryParseTraversalStrategy(
            $normalized,
            $isCaseInsensitive,
            [ref]$parsed
        )
        if (-not $isValid) {
            throw [UseCaseParsingException]::new(
                [DiscoveryRequestParser]::Component, # ComponentName
                ([ApplicationExceptionContext]::TranslateSemanticTokenToDomainValue).ToString(), # Context
                ([ApplicationExceptionReason]::SemanticTokenTranslationFailure).ToString(), # Reason
                "$($semanticName) is not a valid domain-supported value: '$($value)'." # Message
            )
        }
        return $parsed
    }
    
    static [TraversalDepthStrategy] ParseTraversalDepthStrategy (
        [string] $value,
        [System.StringComparison] $comparison
    ) {
        [string]$semanticName = ([ApplicationSemanticNames]::TraversalDepthStrategy).ToString()
        if ([System.String]::IsNullOrWhiteSpace($value)) {
            throw [UseCaseParsingException]::new(
                [DiscoveryRequestParser]::Component, # ComponentName
                ([ApplicationExceptionContext]::AssertSemanticTokenMeaningfulness).ToString(), # Context
                ([ApplicationExceptionReason]::SemanticTokenNullOrWhiteSpace).ToString(), # Reason
                "$($semanticName) must not be null, empty, or whitespace." # Message
            )
        }
        [string]$normalized = [TraversalDepthStrategyNormalizer]::Normalize($value, $comparison)
        [bool]$isCaseInsensitive = [StringComparisonInspector]::IsCaseInsensitive($comparison)
        $parsed = $null
        [bool]$isValid = [DiscoveryRequestParser]::TryParseTraversalDepthStrategy(
            $normalized,
            $isCaseInsensitive,
            [ref]$parsed
        )
        if (-not $isValid) {
            throw [UseCaseParsingException]::new(
                [DiscoveryRequestParser]::Component, # ComponentName
                ([ApplicationExceptionContext]::TranslateSemanticTokenToDomainValue).ToString(), # Context
                ([ApplicationExceptionReason]::SemanticTokenTranslationFailure).ToString(), # Reason
                "$($semanticName) is not a valid domain-supported value: '$($value)'." # Message
            )
        }
        return $parsed
    }
    
}