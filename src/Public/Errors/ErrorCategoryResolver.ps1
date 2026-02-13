class ErrorCategoryResolver {
    
    static [System.Management.Automation.ErrorCategory] ResolveFromReason (
        [string] $applicationExceptionReason
    ) {
        switch ($applicationExceptionReason) {
            'SemanticTokenNullOrWhiteSpace' {
                return [System.Management.Automation.ErrorCategory]::InvalidArgument
            }
            'SemanticTokenCollectionIsNull' {
                return [System.Management.Automation.ErrorCategory]::InvalidArgument
            }
            'SemanticTokenCollectionIsEmpty' {
                return [System.Management.Automation.ErrorCategory]::InvalidArgument
            }
            'SemanticTokenCollectionNotProvided' {
                return [System.Management.Automation.ErrorCategory]::InvalidArgument
            }
            'SemanticTokenTranslationFailure' {
                return [System.Management.Automation.ErrorCategory]::InvalidArgument
            }
            'DomainInvariantViolation' {
                return [System.Management.Automation.ErrorCategory]::InvalidOperation
            }
            'InputPathsResolutionFailure' {
                return [System.Management.Automation.ErrorCategory]::ResourceUnavailable
            }
            'DirectoryTraversalFailed' {
                return [System.Management.Automation.ErrorCategory]::ReadError
            }
            default {
                throw [System.InvalidOperationException]::new(
                    'Unknown application exception reason in ResolveFromReason.'
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in ResolveFromReason.'
        )
    }
    
}