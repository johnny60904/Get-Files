class DiscoveryRequestAssertions {
    
    static [void] AssertDirectoryPathMeaningful (
        [string] $directoryPath
    ) {
        if (-not ([DiscoveryRequestRules]::IsDirectoryPathMeaningful($directoryPath))) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::DirectoryPath
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryRequest,
                [DomainRuleNames]::AssertSemanticTokenMeaningfulness,
                $semanticIdentity,
                "'$($semanticName)' is required.",
                $directoryPath
            )
        }
    }
    
    static [void] AssertFileFilterMeaningful (
        [string] $fileFilter
    ) {
        if (-not ([DiscoveryRequestRules]::IsFileFilterMeaningful($fileFilter))) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::FileFilter
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryRequest,
                [DomainRuleNames]::AssertSemanticTokenMeaningfulness,
                $semanticIdentity,
                "'$($semanticName)' is required.",
                $fileFilter
            )
        }
    }
    
    static [void] AssertShallowRequest (
        [TraversalScope] $traversalScope
    ) {
        if (-not ([DiscoveryRequestRules]::IsShallowRequest($traversalScope))) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::TraversalScope
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryRequest,
                [DomainRuleNames]::AssertSemanticTokenMeaningfulness,
                $semanticIdentity,
                "'$($semanticName)' value is invalid for shallow request.",
                $traversalScope
            )
        }
    }
    
    static [void] AssertRecursiveRequest (
        [TraversalScope] $traversalScope
    ) {
        if (-not ([DiscoveryRequestRules]::IsRecursiveRequest($traversalScope))) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::TraversalScope
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryRequest,
                [DomainRuleNames]::AssertSemanticTokenMeaningfulness,
                $semanticIdentity,
                "'$($semanticName)' value is invalid for recursive request.",
                $traversalScope
            )
        }
    }
    
}