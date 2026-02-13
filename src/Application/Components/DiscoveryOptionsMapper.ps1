class DiscoveryOptionsMapper {
    
    hidden static [string] $Component = 'DiscoveryOptionsMapper'
    
    static [TraversalOptions] Map (
        [bool] $skipInaccessibleEntries,
        [string] $nameCaseSensitivity,
        [int] $entryReadBufferSize,
        # from Cmdlet switches
        [bool] $skipFileAttributeHidden,
        [bool] $skipFileAttributeSystem,
        [bool] $skipFileAttributeReadOnly,
        # from AdvancedOptions
        [string[]] $skipFileAttributes
    ) {
        [SkipFileAttributes]$flagsFromSwitches = [SkipFileAttributes]::None
        [SkipFileAttributes]$flagsFromSwitches = ($flagsFromSwitches -bor 
            ([SkipFileAttributesAssembler]::ResolveHidden($skipFileAttributeHidden)) -bor 
            ([SkipFileAttributesAssembler]::ResolveSystem($skipFileAttributeSystem)) -bor 
            ([SkipFileAttributesAssembler]::ResolveReadOnly($skipFileAttributeReadOnly)))
        [SkipFileAttributes]$flagsFromAdvanced = if ($skipFileAttributes) {
            [DiscoveryOptionsParser]::ParseSkipFileAttributes( # ParsingException
                $skipFileAttributes,
                [SkipFileAttributesComparison]::Comparison
            )
        } else {
            [SkipFileAttributes]::None
        }
        [SkipFileAttributes]$finalFlags = ($flagsFromSwitches -bor $flagsFromAdvanced)
        # build Domain object
        [TraversalOptions]$traversalOptions = [TraversalOptions]::new(
            $skipInaccessibleEntries,
            (
                [DiscoveryOptionsParser]::ParseNameCaseSensitivity( # ParsingException
                    $nameCaseSensitivity,
                    [NameCaseSensitivityComparison]::Comparison)
            ),
            $entryReadBufferSize,
            $flagsFromAdvanced
        )
        [string]$semanticName = ([ApplicationParameter]::TraversalOptions).ToString()
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