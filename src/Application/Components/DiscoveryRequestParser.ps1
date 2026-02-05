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
        [switch] $flag,
        [System.StringComparison] $comparison
    ) {
        [string]$semanticName = ([ApplicationSemanticNames]::TraversalStrategy).ToString()
        [string]$mapped = [TraversalStrategyMapper]::FromSwitchFlag($flag)
        [bool]$isCaseInsensitive = [StringComparisonInspector]::IsCaseInsensitive($comparison)
        $parsed = $null
        [bool]$isValid = [DiscoveryRequestParser]::TryParseTraversalStrategy(
            $mapped,
            $isCaseInsensitive,
            [ref]$parsed
        )
        if (-not $isValid) {
            throw [UseCaseParsingException]::new(
                [DiscoveryRequestParser]::Component, # ComponentName
                ([ApplicationExceptionContext]::TranslateSemanticTokenToDomainValue).ToString(), # Context
                ([ApplicationExceptionReason]::SemanticTokenTranslationFailure).ToString(), # Reason
                "$($semanticName) is not a valid domain-supported value: '$($flag)'." # Message
            )
        }
        return $parsed
    }
    
    static [TraversalDepthStrategy] ParseTraversalDepthStrategy (
        [switch] $flag,
        [System.StringComparison] $comparison
    ) {
        [string]$semanticName = ([ApplicationSemanticNames]::TraversalDepthStrategy).ToString()
        [string]$mapped = [TraversalDepthStrategyMapper]::FromSwitchFlag($flag)
        [bool]$isCaseInsensitive = [StringComparisonInspector]::IsCaseInsensitive($comparison)
        $parsed = $null
        [bool]$isValid = [DiscoveryRequestParser]::TryParseTraversalDepthStrategy(
            $mapped,
            $isCaseInsensitive,
            [ref]$parsed
        )
        if (-not $isValid) {
            throw [UseCaseParsingException]::new(
                [DiscoveryRequestParser]::Component, # ComponentName
                ([ApplicationExceptionContext]::TranslateSemanticTokenToDomainValue).ToString(), # Context
                ([ApplicationExceptionReason]::SemanticTokenTranslationFailure).ToString(), # Reason
                "$($semanticName) is not a valid domain-supported value: '$($flag)'." # Message
            )
        }
        return $parsed
    }
    
}