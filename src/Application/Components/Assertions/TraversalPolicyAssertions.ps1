
class TraversalPolicyAssertions {
    
    hidden static [string] $Component = 'TraversalPolicyAssertions'
    
    static [void] AssertRequest (
        [bool] $recurseSubdirectories,
        [string] $traversalStrategyToken
    ) {
        [ApplicationParameter]$semanticIdentity = [ApplicationParameter]::TraversalStrategy
        [string]$semanticName = $semanticIdentity.ToString()
        if ((-not $recurseSubdirectories) -and ($traversalStrategyToken)) {
            throw [UseCaseInvariantViolationException]::new(
                [TraversalPolicyAssertions]::Component, # ComponentName
                [ApplicationExceptionContext]::AssertSemanticTokenInvariants, # Context
                [ApplicationExceptionReason]::InvariantViolation, # Reason
                $semanticIdentity, # FieldName
                $traversalStrategyToken, # TargetObject
                "$($semanticName) only allowed for qualified $(([ApplicationParameter]::TraversalScope).ToString())." # Message
            )
        }
    }
    
}