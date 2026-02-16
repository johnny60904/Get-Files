class DiscoveryRequestMapper {
    
    hidden static [string] $Component = 'DiscoveryRequestMapper'
    
    static [DiscoveryRequest] Map (
        [string] $directoryPath,
        [string[]] $childNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [bool] $recurseSubdirectories,
        [bool] $depthFirst
    ) {
        [TraversalScope]$traversalScope = [TraversalPolicyAssembler]::ResolveScope($recurseSubdirectories)
        [TraversalStrategy]$traversalStrategy = [TraversalPolicyAssembler]::ResolveStrategy($depthFirst)
        try {
            return [DiscoveryRequest]::new(
                $directoryPath,
                $childNames,
                $fileFilter,
                $traversalOptions,
                $traversalScope,
                $traversalStrategy
            )
        } catch [DomainException] {
            [ApplicationParameter]$semanticIdentity = [ApplicationParameter]::DiscoveryRequest
            [string]$semanticName = $semanticIdentity.ToString()
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