class DiscoveryProfileMapper {
    
    hidden static [string] $Component = 'DiscoveryProfileMapper'
    
    static [DiscoveryProfile] Map (
        [string[]] $excludeNames,
        [string] $fileFilter,
        [int] $maxDepthThresholdRaw, # [int] $null
        [TraversalOptions] $traversalOptions,
        [bool] $recurseSubdirectories,
        [string] $traversalStrategyToken # [string] $null
    ) {
        [TraversalPolicyAssertions]::AssertMaxDepthThreshold($recurseSubdirectories, $maxDepthThresholdRaw) # Invariant Exception
        [TraversalPolicyAssertions]::AssertScopeAndStrategy($recurseSubdirectories, $traversalStrategyToken) # Invariant Exception
        [int]$maxDepthThreshold = if ($recurseSubdirectories -and ($maxDepthThresholdRaw -eq 0)) {
            [TraversalPolicyDefaults]::DefaultMaxDepthThresholdWhenRecurse
        } else { $maxDepthThresholdRaw }
        [TraversalScope]$traversalScope = [TraversalPolicyAssembler]::ResolveScope($recurseSubdirectories)
        [TraversalStrategy]$traversalStrategy = if ($traversalStrategyToken) {
            [DiscoveryProfileParser]::ParseTraversalStrategy( # Parsing Exception
                [TraversalStrategyNormalizer]::NormalizeStrategyToken($traversalStrategyToken), # Normalization Exception
                [TraversalStrategyComparison]::Comparison
            )
        } else { [TraversalPolicyDefaults]::DefaultTraversalStrategy }
        try {
            return [DiscoveryProfileSelector]::Select(
                $excludeNames,
                $fileFilter,
                $maxDepthThreshold,
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