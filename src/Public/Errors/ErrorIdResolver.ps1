class ErrorIdResolver {
    
    static [string] ResolveFromReason (
        [ApplicationExceptionReason] $applicationExceptionReason
    ) {
        switch ($applicationExceptionReason) {
            ([ApplicationExceptionReason]::SemanticTokenNullOrWhiteSpace) {
                return ([PublicErrorId]::XXXXXXXXX).ToString()
            }
            ([ApplicationExceptionReason]::SemanticTokenCollectionIsNull) {
                return ([PublicErrorId]::XXXXXXXXX).ToString()
            }
            ([ApplicationExceptionReason]::SemanticTokenCollectionIsEmpty) {
                return ([PublicErrorId]::XXXXXXXXX).ToString()
            }
            ([ApplicationExceptionReason]::SemanticTokenCollectionNotProvided) {
                return ([PublicErrorId]::XXXXXXXXX).ToString()
            }
            ([ApplicationExceptionReason]::SemanticTokenTranslationFailure) {
                return ([PublicErrorId]::XXXXXXXXX).ToString()
            }
            ([ApplicationExceptionReason]::DomainInvariantViolation) {
                return ([PublicErrorId]::XXXXXXXXX).ToString()
            }
            ([ApplicationExceptionReason]::InputPathsResolutionFailure) {
                return ([PublicErrorId]::XXXXXXXXX).ToString()
            }
            ([ApplicationExceptionReason]::DirectoryTraversalFailed) {
                return ([PublicErrorId]::XXXXXXXXX).ToString()
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