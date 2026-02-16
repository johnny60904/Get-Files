class ErrorMessageFormatter {
    
    static [string] FormateFromApplicationException (
        [ApplicationException] $applicationException
    ) {
        [string]$paramName = ([CmdletParameterNameResolver]::ResolveFromFieldName($applicationException.FieldName)).ToString()
        switch ($applicationException.Reason) {
            ([ApplicationExceptionReason]::NullOrWhiteSpace) {
                return "The parameter '$($paramName)' must not be null, empty, or whitespace."
            }
            ([ApplicationExceptionReason]::CollectionIsNull) {
                return "The parameter '$($paramName)' must not be null."
            }
            ([ApplicationExceptionReason]::CollectionIsEmpty) {
                return "The parameter '$($paramName)' must not be empty."
            }
            ([ApplicationExceptionReason]::CollectionNotProvided) {
                return "The parameter '$($paramName)' unprovided.   Please provide a valid value and try again."
            }
            ([ApplicationExceptionReason]::TranslationFailure) {
                return "The parameter '$($paramName)' invalid.   Please check and try again."
            }
            ([ApplicationExceptionReason]::InvariantViolation) {
                return "Operation invalid (could be parameter(s) invalid).   Please check and try again."
            }
            ([ApplicationExceptionReason]::ResolutionFailure) {
                return "Operation invalid (could be parameter(s) invalid).   Please check and try again."
            }
            ([ApplicationExceptionReason]::TraversalFailure) {
                return "Traversal operation failed.   Please check and try again."
            }
            default {
                throw [System.InvalidOperationException]::new(
                    'Unknown identifier name for [ApplicationExceptionReason] in FormateFromApplicationException.'
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in FormateFromApplicationException.'
        )
    }
    
}