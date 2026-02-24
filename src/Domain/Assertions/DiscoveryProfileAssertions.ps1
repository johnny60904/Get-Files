class DiscoveryProfileAssertions {
    
    static [void] AssertExcludeNamesAllowedAbsence (
        [string[]] $excludeNames
    ) {
        if ([DiscoveryProfileRules]::IsExcludeNamesAllowedAbsence($excludeNames)) { return }
    }
    
    static [void] AssertExcludeNamesMeaningful (
        [string[]] $excludeNames
    ) {
        if (-not ([DiscoveryProfileRules]::IsExcludeNamesMeaningful($excludeNames))) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::ExcludeName
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryProfile,
                [DomainRuleNames]::AssertSemanticTokenCollectionMeaningfulness,
                $semanticIdentity,
                "'$($semanticName)' is required.",
                $excludeNames
            )
        }
    }
    
    static [void] AssertFileFilterMeaningful (
        [string] $fileFilter
    ) {
        if (-not ([DiscoveryProfileRules]::IsFileFilterMeaningful($fileFilter))) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::FileFilter
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryProfile, # ModelName
                [DomainRuleNames]::AssertSemanticTokenMeaningfulness, # RuleName
                $semanticIdentity, # SemanticName
                "'$($semanticName)' is required.", # Message
                $fileFilter # TargetObject
            )
        }
    }
    
    static [void] AssertMaxDepthThresholdForShallow (
        [string] $maxDepthThreshold
    ) {
        if (-not ([DiscoveryProfileRules]::IsMaxDepthThresholdValidForShallow($maxDepthThreshold))) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::MaxDepthThreshold
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryProfile, # ModelName
                [DomainRuleNames]::AssertDomainModelInvariants, # RuleName
                $semanticIdentity, # SemanticName
                "'$($semanticName)' value out of range for shallow profile.", # Message
                $maxDepthThreshold # TargetObject
            )
        }
    }
    
    static [void] AssertMaxDepthThresholdForRecursive (
        [string] $maxDepthThreshold
    ) {
        if (-not ([DiscoveryProfileRules]::IsMaxDepthThresholdValidForRecursive($maxDepthThreshold))) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::MaxDepthThreshold
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryProfile, # ModelName
                [DomainRuleNames]::AssertDomainModelInvariants, # RuleName
                $semanticIdentity, # SemanticName
                "'$($semanticName)' value out of range for recursive profile.", # Message
                $maxDepthThreshold # TargetObject
            )
        }
    }
    
    static [void] AssertShallowProfile (
        [TraversalScope] $traversalScope
    ) {
        if (-not ([DiscoveryProfileRules]::IsShallowRequest($traversalScope))) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::TraversalScope
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryProfile, # ModelName
                [DomainRuleNames]::AssertDomainModelInvariants, # RuleName
                $semanticIdentity, # SemanticName
                "'$($semanticName)' value incorresponded to the profile.", # Message
                $traversalScope # TargetObject
            )
        }
    }
    
    static [void] AssertRecursiveProfile (
        [TraversalScope] $traversalScope
    ) {
        if (-not ([DiscoveryProfileRules]::IsRecursiveRequest($traversalScope))) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::TraversalScope
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryProfile, # ModelName
                [DomainRuleNames]::AssertDomainModelInvariants, # RuleName
                $semanticIdentity, # SemanticName
                "'$($semanticName)' value incorresponded to the profile.", # Message
                $traversalScope # TargetObject
            )
        }
    }
    
}