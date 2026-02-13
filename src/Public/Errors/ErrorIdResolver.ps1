class ErrorIdResolver {
    
    static [string] ResolveFromReason (
        [string] $applicationExceptionReason
    ) {
        switch ($applicationExceptionReason) {
            'SemanticTokenNullOrWhiteSpace' {
                return [PublicErrorId]::XXXXXXXXX
            }
            'SemanticTokenCollectionIsNull' {
                return [PublicErrorId]::XXXXXXXXX
            }
            'SemanticTokenCollectionIsEmpty' {
                return [PublicErrorId]::XXXXXXXXX
            }
            'SemanticTokenCollectionNotProvided' {
                return [PublicErrorId]::XXXXXXXXX
            }
            'SemanticTokenTranslationFailure' {
                return [PublicErrorId]::XXXXXXXXX
            }
            'DomainInvariantViolation' {
                return [PublicErrorId]::XXXXXXXXX
            }
            'InputPathsResolutionFailure' {
                return [PublicErrorId]::XXXXXXXXX
            }
            'DirectoryTraversalFailed' {
                return [PublicErrorId]::XXXXXXXXX
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