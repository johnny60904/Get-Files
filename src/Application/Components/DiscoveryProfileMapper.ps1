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
        try {
            return [DiscoveryProfileSelector]::Select(
                $excludeNames,
                $fileFilter,
                $traversalOptions,
                $traversalScope,
                $traversalStrategy
            )
        } catch [DomainException] {
            [ApplicationParameter]$semanticIdentity = [ApplicationParameterConverter]::FromDomainException($_)
            [string]$semanticName = $semanticIdentity.ToString()
            throw [UseCaseInvariantViolationException]::new(
                [DiscoveryProfileMapper]::Component, # ComponentName
                [ApplicationExceptionContext]::TranslateSemanticTokensToDomainModel, # Context
                [ApplicationExceptionReasonConverter]::FromDomainException($_), # Reason
                $semanticIdentity, # FieldName
                $_.Exception.TargetObject, # TargetObject
                "$($semanticName) violated one or more invariant rules.", # Message
                $_.Exception # InnerException
            )
        }
    }
    
}