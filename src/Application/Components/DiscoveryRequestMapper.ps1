class DiscoveryRequestMapper {
    
    hidden static [string] $Component = 'DiscoveryRequestMapper'
    
    static [DiscoveryRequest] Map (
        [string] $directoryPath,
        [string[]] $childNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [bool] $recurseSubdirectories,
        [string] $traversalStrategyToken
    ) {
        [TraversalPolicyAssertions]::AssertRequest($recurseSubdirectories, $traversalStrategyToken) # Invariant Exception
        [TraversalScope]$traversalScope = [TraversalPolicyAssembler]::ResolveScope($recurseSubdirectories)
        [TraversalStrategy]$traversalStrategy = if ($traversalStrategyToken) {
            [DiscoveryRequestParser]::ParseTraversalStrategy( # Parsing Exception
                [TraversalStrategyNormalizer]::NormalizeStrategyToken($traversalStrategyToken), # Normalization Exception
                [TraversalStrategyComparison]::Comparison
            )
        } else { [TraversalPolicyDefaults]::RecursiveDefault }
        [ApplicationParameter]$semanticIdentity = [ApplicationParameter]::DiscoveryRequest
        [string]$semanticName = $semanticIdentity.ToString()
        try {
            return [DiscoveryRequestSelector]::Select(
                $directoryPath,
                $childNames,
                $fileFilter,
                $traversalOptions,
                $traversalScope,
                $traversalStrategy
            )
        } catch [DomainException] {
            throw [UseCaseInvariantViolationException]::new(
                [DiscoveryRequestMapper]::Component, # ComponentName
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