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
                [DomainRuleNames]::AssertSemanticTokenMeaningfulness,
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
    
    static [void] AssertShallowProfile (
        [TraversalScope] $traversalScope
    ) {
        if (-not ([DiscoveryProfileRules]::IsShallowProfile($traversalScope))) {
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
        if (-not ([DiscoveryProfileRules]::IsRecursiveProfile($traversalScope))) {
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