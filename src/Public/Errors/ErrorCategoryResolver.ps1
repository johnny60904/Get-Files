class ErrorCategoryResolver {
    
    static [System.Management.Automation.ErrorCategory] ResolveFromReason (
        [ApplicationExceptionReason] $applicationExceptionReason
    ) {
        switch ($applicationExceptionReason) {
            ([ApplicationExceptionReason]::NullOrWhiteSpace) {
                return [System.Management.Automation.ErrorCategory]::InvalidArgument
            }
            ([ApplicationExceptionReason]::CollectionIsNull) {
                return [System.Management.Automation.ErrorCategory]::InvalidArgument
            }
            ([ApplicationExceptionReason]::CollectionIsEmpty) {
                return [System.Management.Automation.ErrorCategory]::InvalidArgument
            }
            ([ApplicationExceptionReason]::CollectionNotProvided) {
                return [System.Management.Automation.ErrorCategory]::InvalidArgument
            }
            ([ApplicationExceptionReason]::TranslationFailure) {
                return [System.Management.Automation.ErrorCategory]::InvalidArgument
            }
            ([ApplicationExceptionReason]::InvariantViolation) {
                return [System.Management.Automation.ErrorCategory]::InvalidOperation
            }
            ([ApplicationExceptionReason]::ResolutionFailure) {
                return [System.Management.Automation.ErrorCategory]::ResourceUnavailable
            }
            ([ApplicationExceptionReason]::TraversalFailure) {
                return [System.Management.Automation.ErrorCategory]::ReadError
            }
            default {
                throw [System.InvalidOperationException]::new(
                    'Unknown identifier name for [ApplicationExceptionReason] in ResolveFromReason.'
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in ResolveFromReason.'
        )
    }
    
}