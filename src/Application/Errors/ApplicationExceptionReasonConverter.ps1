class ApplicationExceptionReasonConverter {
    
    static [ApplicationExceptionReason] FromDomainException (
        [DomainException] $exception
    ) {
        switch ($exception.RuleName) {
            ([DomainRuleNames]::AssertSemanticTokenMeaningfulness) {
                return [ApplicationExceptionReason]::NullOrWhiteSpace
            }
            ([DomainRuleNames]::AssertSemanticTokenCollectionMeaningfulness) {
                return [ApplicationExceptionReason]::CollectionNotProvided
            }
            ([DomainRuleNames]::AssertDomainModelInvariants) {
                return [ApplicationExceptionReason]::InvariantViolation
            }
            default {
                throw [System.InvalidOperationException]::new(
                    "Unknown identifier name for [DomainRuleNames] in FromDomainException."
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            "Unreachable code path in FromDomainException."
        )
    }
    
}