class DiscoveryOptionsFactory {
    
    hidden static [string] $Component = 'DiscoveryOptionsFactory'
    
    static [TraversalOptions] CreateDefaultOptions () {
        return [TraversalOptions]::new(
            [TraversalOptionsDefaults]::SkipInaccessibleEntries, # ContinueOnAccessDenied -> SkipInaccessibleEntries
            [TraversalOptionsDefaults]::EntryReadBufferSize, # IOBufferSize -> EntryReadBufferSize
            [TraversalOptionsDefaults]::SkipFileAttributes, # ExcludedFileAttributes -> SkipFileAttributes
            [TraversalOptionsDefaults]::NameCaseSensitivity # MatchCaseSensitivity -> NameCaseSensitivity
        )
    }
    
    static [TraversalOptions] MapOptions (
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
                [DiscoveryOptionsFactory]::Component, # ComponentName
                ([ApplicationExceptionContext]::TranslateSemanticTokensToDomainModel).ToString(), # Context
                ([ApplicationExceptionReason]::DomainInvariantViolation).ToString(), # Reason
                "$($semanticName) violate one or more invariant rules.", # Message
                $_.Exception # InnerException
            )
        }
        return $traversalOptions
    }
    
}