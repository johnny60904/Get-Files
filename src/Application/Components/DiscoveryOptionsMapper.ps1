class DiscoveryOptionsMapper {
    
    hidden static [string] $Component = 'DiscoveryOptionsMapper'
    
    static [TraversalOptions] Map (
        [bool] $continueOnAccessDenied,
        [int] $ioBufferSize,
        [string[]] $excludedFileAttributes,
        [string] $matchCaseSensitivity
    ) {
        [TraversalOptions]$traversalOptions = [TraversalOptions]::new(
            $continueOnAccessDenied,
            $ioBufferSize,
            ([DiscoveryOptionsParser]::ParseSkipFileAttributes($excludedFileAttributes, [SkipFileAttributesComparison]::Comparison)), # ParsingException
            ([DiscoveryOptionsParser]::ParseNameCaseSensitivity($matchCaseSensitivity, [NameCaseSensitivityComparison]::Comparison)) # ParsingException
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