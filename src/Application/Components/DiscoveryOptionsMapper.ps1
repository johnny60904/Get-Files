class DiscoveryOptionsMapper {
    
    hidden static [string] $Component = 'DiscoveryOptionsMapper'
    
    static [TraversalOptions] Map (
        [bool] $ignoreErrors,
        [string] $caseSensitivity,
        [int] $bufferSizeKB,
        [string[]] $excludeAttributes
    ) {
        [TraversalOptions]$traversalOptions = [TraversalOptions]::new(
            $ignoreErrors,
            ([DiscoveryOptionsParser]::ParseNameCaseSensitivity($caseSensitivity, [NameCaseSensitivityComparison]::Comparison)), # ParsingException
            $bufferSizeKB,
            ([DiscoveryOptionsParser]::ParseSkipFileAttributes($excludeAttributes, [SkipFileAttributesComparison]::Comparison)) # ParsingException
        )
        [string]$semanticName = ([ApplicationSemanticNames]::TraversalOptions).ToString()
        try { [TraversalRules]::AssertAdvancedOptionsValid($traversalOptions) } catch [DomainException] {
            throw [UseCaseInvariantViolationException]::new(
                [DiscoveryOptionsMapper]::Component, # ComponentName
                ([ApplicationExceptionContext]::TranslateSemanticTokensToDomainModel).ToString(), # Context
                ([ApplicationExceptionReason]::DomainInvariantViolation).ToString(), # Reason
                "$($semanticName) violate one or more invariant rules.", # Message
                $_.Exception # InnerException
            )
        }
        return $traversalOptions
    }
    
}