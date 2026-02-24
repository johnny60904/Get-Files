class DiscoveryRequestFactory {
    
    hidden static [string] $Component = 'DiscoveryRequestFactory'
    
    static [DiscoveryRequest] Create (
        [string] $directoryPath,
        [DiscoveryProfile] $discoveryProfile
    ) {
        try {
            return [DiscoveryRequest]::new(
                $directoryPath,
                $discoveryProfile
            )
        } catch [DomainException] {
            [ApplicationParameter]$semanticIdentity = [ApplicationParameter]::DiscoveryRequest
            [string]$semanticName = $semanticIdentity.ToString()
            throw [UseCaseInvariantViolationException]::new(
                [DiscoveryRequestFactory]::Component, # ComponentName
                [ApplicationExceptionContext]::TranslateSemanticTokenToDomainValue, # Context
                [ApplicationExceptionReason]::InvariantViolation, # Reason
                $semanticIdentity, # FieldName
                $_.Exception.TargetObject, # TargetObject
                "$($semanticName) violated one or more invariant rules.", # Message
                $_.Exception # InnerException
            )
        }
    }
    
}