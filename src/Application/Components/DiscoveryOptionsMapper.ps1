class DiscoveryOptionsMapper {
    
    hidden static [string] $Component = 'DiscoveryOptionsMapper'
    
    static [TraversalOptions] Map (
        [bool] $ignoreErrors,
        [int] $bufferSizeKB,
        [string[]] $excludeAttributes,
        [string] $caseSensitivity
    ) {
        [TraversalOptions]$traversalOptions = [TraversalOptions]::new(
            $ignoreErrors,
            $bufferSizeKB,
            ([DiscoveryOptionsParser]::ParseSkipFileAttributes($excludeAttributes, [SkipFileAttributesComparison]::Comparison)), # ParsingException
            ([DiscoveryOptionsParser]::ParseNameCaseSensitivity($caseSensitivity, [NameCaseSensitivityComparison]::Comparison)) # ParsingException
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