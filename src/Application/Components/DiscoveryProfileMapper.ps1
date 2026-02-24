class DiscoveryProfileMapper {
    
    hidden static [string] $Component = 'DiscoveryProfileMapper'
    
    static [DiscoveryProfile] Map (
        [string[]] $excludeNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [bool] $recurseSubdirectories,
        [string] $traversalStrategyToken
    ) {
        [TraversalPolicyAssertions]::AssertProfile($recurseSubdirectories, $traversalStrategyToken) # Invariant Exception
        [TraversalScope]$traversalScope = [TraversalPolicyAssembler]::ResolveScope($recurseSubdirectories)
        [TraversalStrategy]$traversalStrategy = if ($traversalStrategyToken) {
            [DiscoveryProfileParser]::ParseTraversalStrategy( # Parsing Exception
                [TraversalStrategyNormalizer]::NormalizeStrategyToken($traversalStrategyToken), # Normalization Exception
                [TraversalStrategyComparison]::Comparison
            )
        } else { [TraversalPolicyDefaults]::TraversalStrategyDefault }
        [ApplicationParameter]$semanticIdentity = [ApplicationParameter]::DiscoveryProfile
        [string]$semanticName = $semanticIdentity.ToString()
        try {
            return [DiscoveryProfileSelector]::Select(
                $excludeNames,
                $fileFilter,
                $traversalOptions,
                $traversalScope,
                $traversalStrategy
            )
        } catch [DomainException] {
            throw [UseCaseInvariantViolationException]::new(
                [DiscoveryProfileMapper]::Component, # ComponentName
                [ApplicationExceptionContext]::TranslateSemanticTokensToDomainModel, # Context
                [ApplicationExceptionReason]::InvariantViolation, # Reason
                $semanticIdentity, # FieldName
                $_.Exception.TargetObject, # TargetObject
                "$($semanticName) violated one or more invariant rules.", # Message
                $_.Exception # InnerException
            )
        }
    }
    
}