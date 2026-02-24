
class TraversalPolicyAssertions {
    
    hidden static [string] $Component = 'TraversalPolicyAssertions'
    
    static [void] AssertMaxDepthThreshold (
        [bool] $recurseSubdirectories,
        [int] $maxDepthThreshold
    ) {
        [ApplicationParameter]$semanticIdentity = [ApplicationParameter]::MaxDepthThreshold
        [string]$semanticName = $semanticIdentity.ToString()
        if ((-not $recurseSubdirectories) -and ($maxDepthThreshold -gt 0)) {
            throw [UseCaseInvariantViolationException]::new(
                [TraversalPolicyAssertions]::Component, # ComponentName
                [ApplicationExceptionContext]::AssertSemanticTokenInvariants, # Context
                [ApplicationExceptionReason]::InvariantViolation, # Reason
                $semanticIdentity, # FieldName
                $maxDepthThreshold, # TargetObject
                "$($semanticName) only allowed for corresponded $(([ApplicationParameter]::TraversalScope).ToString())." # Message
            )
        }
    }
    
    static [void] AssertScopeAndStrategy (
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
                "$($semanticName) only allowed for corresponded $(([ApplicationParameter]::TraversalScope).ToString())." # Message
            )
        }
    }
    
}