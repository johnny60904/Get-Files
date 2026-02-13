class ErrorCategoryResolver {
    
    static [System.Management.Automation.ErrorCategory] ResolveFromReason (
        [ApplicationExceptionReason] $applicationExceptionReason
    ) {
        switch ($applicationExceptionReason) {
            ([ApplicationExceptionReason]::SemanticTokenNullOrWhiteSpace) {
                return [System.Management.Automation.ErrorCategory]::InvalidArgument
            }
            ([ApplicationExceptionReason]::SemanticTokenCollectionIsNull) {
                return [System.Management.Automation.ErrorCategory]::InvalidArgument
            }
            ([ApplicationExceptionReason]::SemanticTokenCollectionIsEmpty) {
                return [System.Management.Automation.ErrorCategory]::InvalidArgument
            }
            ([ApplicationExceptionReason]::SemanticTokenCollectionNotProvided) {
                return [System.Management.Automation.ErrorCategory]::InvalidArgument
            }
            ([ApplicationExceptionReason]::SemanticTokenTranslationFailure) {
                return [System.Management.Automation.ErrorCategory]::InvalidArgument
            }
            ([ApplicationExceptionReason]::DomainInvariantViolation) {
                return [System.Management.Automation.ErrorCategory]::InvalidOperation
            }
            ([ApplicationExceptionReason]::InputPathsResolutionFailure) {
                return [System.Management.Automation.ErrorCategory]::ResourceUnavailable
            }
            ([ApplicationExceptionReason]::DirectoryTraversalFailed) {
                return [System.Management.Automation.ErrorCategory]::ReadError
            }
            default {
                throw [System.InvalidOperationException]::new(
                    'Unknown identifier for [ApplicationExceptionReason] in ResolveFromReason.'
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in ResolveFromReason.'
        )
    }
    
}