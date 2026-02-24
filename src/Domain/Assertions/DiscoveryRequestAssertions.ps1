class DiscoveryRequestAssertions {
    
    static [void] AssertDirectoryPathMeaningful (
        [string] $directoryPath
    ) {
        if (-not ([DiscoveryRequestRules]::IsDirectoryPathMeaningful($directoryPath))) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::DirectoryPath
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryRequest, # ModelName
                [DomainRuleNames]::AssertSemanticTokenMeaningfulness, # RuleName
                $semanticIdentity, # SemanticName
                "'$($semanticName)' is required.", # Message
                $directoryPath # TargetObject
            )
        }
    }
    
}