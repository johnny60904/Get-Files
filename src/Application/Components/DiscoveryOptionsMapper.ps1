class DiscoveryOptionsMapper {
    
    hidden static [string] $Component = 'DiscoveryOptionsMapper'
    
    static [TraversalOptions] Map (
        [bool] $ignoreErrors,
        [string] $caseSensitivity,
        [int] $bufferSizeKB,
        # from Cmdlet switches
        [bool] $excludeHidden,
        [bool] $excludeSystem,
        [bool] $excludeReadOnly,
        # from AdvancedOptions
        [string[]] $excludeAttributes
    ) {
        [SkipFileAttributes]$flagsFromSwitches = [SkipFileAttributes]::None
        [SkipFileAttributes]$flagsFromSwitches = ($flagsFromSwitches -bor 
            ([SkipFileAttributesAssembler]::ResolveHidden($excludeHidden)) -bor 
            ([SkipFileAttributesAssembler]::ResolveSystem($excludeSystem)) -bor 
            ([SkipFileAttributesAssembler]::ResolveReadOnly($excludeReadOnly)))
        [SkipFileAttributes]$flagsFromAdvanced = if ($excludeAttributes) {
            [DiscoveryOptionsParser]::ParseSkipFileAttributes( # ParsingException
                $excludeAttributes,
                [SkipFileAttributesComparison]::Comparison
            )
        } else {
            [SkipFileAttributes]::None
        }
        [SkipFileAttributes]$finalFlags = ($flagsFromSwitches -bor $flagsFromAdvanced)
        # build Domain object
        [TraversalOptions]$traversalOptions = [TraversalOptions]::new(
            $ignoreErrors,
            (
                [DiscoveryOptionsParser]::ParseNameCaseSensitivity( # ParsingException
                    $caseSensitivity,
                    [NameCaseSensitivityComparison]::Comparison)
            ),
            $bufferSizeKB,
            $flagsFromAdvanced
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