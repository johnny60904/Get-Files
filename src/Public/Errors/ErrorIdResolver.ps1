class ErrorIdResolver {
    
    static [string] ResolveFromApplicationException (
        [ApplicationException] $applicationException
    ) {
        [string]$paramName = ([CmdletParameterNameResolver]::ResolveFromFieldName($applicationException.FieldName)).ToString()
        switch ($applicationException.Reason) {
            ([ApplicationExceptionReason]::NullOrWhiteSpace) {
                return "$($paramName)NullOrWhiteSpace"
            }
            ([ApplicationExceptionReason]::CollectionIsNull) {
                return "$($paramName)Null"
            }
            ([ApplicationExceptionReason]::CollectionIsEmpty) {
                return "$($paramName)Empty"
            }
            ([ApplicationExceptionReason]::CollectionNotProvided) {
                return "$($paramName)NotProvided"
            }
            ([ApplicationExceptionReason]::TranslationFailure) {
                return "Invalid$($paramName)"
            }
            ([ApplicationExceptionReason]::InvariantViolation) {
                return "InvalidOperation"
            }
            ([ApplicationExceptionReason]::ResolutionFailure) {
                return "Invalid$($paramName)"
            }
            ([ApplicationExceptionReason]::TraversalFailure) {
                return "InvalidOperation"
            }
            default {
                throw [System.InvalidOperationException]::new(
                    'Unknown identifier name for [ApplicationExceptionReason] in ResolveFromApplicationException.'
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in ResolveFromApplicationException.'
        )
    }
    
}