class DiscoveryRequest {
    
    [string] $DirectoryPath
    [string[]] $ChildNames
    [string] $FileFilter
    [TraversalOptions] $TraversalOptions
    [TraversalScope] $TraversalScope
    [TraversalStrategy] $TraversalStrategy
    
    DiscoveryRequest ( # Shallow
        [string] $directoryPath,
        [string[]] $childNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope
    ) {
        if ([System.String]::IsNullOrWhiteSpace($directoryPath)) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::DirectoryPath
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryRequest,
                [DomainRuleNames]::AssertRequestSemanticTokenMeaningfulness,
                $semanticIdentity,
                "'$($semanticName)' is required.",
                $directoryPath
            )
        }
        if ($childNames) {
            for ($i = 0; $i -lt $childNames.Length; $i ++) {
                if ([System.String]::IsNullOrWhiteSpace($childNames[$i])) {
                    [string]$semanticIdentity = [DomainModelSemanticNames]::ChildNames
                    [string]$semanticName = $semanticIdentity.ToString()
                    throw [DomainRuleViolationException]::new(
                        [DomainModelNames]::DiscoveryRequest,
                        [DomainRuleNames]::AssertRequestSemanticTokenMeaningfulness,
                        $semanticIdentity,
                        "'$($semanticName)' is required.",
                        $childNames[$i]
                    )
                }
            }
        }
        if ([System.String]::IsNullOrWhiteSpace($fileFilter)) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::FileFilter
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryRequest,
                [DomainRuleNames]::AssertRequestSemanticTokenMeaningfulness,
                $semanticIdentity,
                "'$($semanticName)' is required.",
                $fileFilter
            )
        }
        if (-not $traversalScope) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::TraversalScope
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryRequest,
                [DomainRuleNames]::AssertRequestSemanticTokenMeaningfulness,
                $semanticIdentity,
                "'$($semanticName)' is required.",
                $traversalScope
            )
        }
        $this.DirectoryPath = $directoryPath
        $this.ChildNames = $childNames
        $this.FileFilter = $fileFilter
        $this.TraversalOptions = $traversalOptions
        $this.TraversalScope = $traversalScope
    }
    
    DiscoveryRequest ( # Recurse
        [string] $directoryPath,
        [string[]] $childNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope,
        [TraversalStrategy] $traversalStrategy
    ) {
        if ([System.String]::IsNullOrWhiteSpace($directoryPath)) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::DirectoryPath
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryRequest,
                [DomainRuleNames]::AssertRequestSemanticTokenMeaningfulness,
                $semanticIdentity,
                "'$($semanticName)' is required.",
                $directoryPath
            )
        }
        if ($childNames) {
            for ($i = 0; $i -lt $childNames.Length; $i ++) {
                if ([System.String]::IsNullOrWhiteSpace($childNames[$i])) {
                    [string]$semanticIdentity = [DomainModelSemanticNames]::ChildNames
                    [string]$semanticName = $semanticIdentity.ToString()
                    throw [DomainRuleViolationException]::new(
                        [DomainModelNames]::DiscoveryRequest,
                        [DomainRuleNames]::AssertRequestSemanticTokenMeaningfulness,
                        $semanticIdentity,
                        "'$($semanticName)' is required.",
                        $childNames[$i]
                    )
                }
            }
        }
        if ([System.String]::IsNullOrWhiteSpace($fileFilter)) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::FileFilter
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryRequest,
                [DomainRuleNames]::AssertRequestSemanticTokenMeaningfulness,
                $semanticIdentity,
                "'$($semanticName)' is required.",
                $fileFilter
            )
        }
        if (-not $traversalScope) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::TraversalScope
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryRequest,
                [DomainRuleNames]::AssertRequestSemanticTokenMeaningfulness,
                $semanticIdentity,
                "'$($semanticName)' is required.",
                $traversalScope
            )
        }
        if (-not $traversalStrategy) {
            [string]$semanticIdentity = [DomainModelSemanticNames]::TraversalStrategy
            [string]$semanticName = $semanticIdentity.ToString()
            throw [DomainRuleViolationException]::new(
                [DomainModelNames]::DiscoveryRequest,
                [DomainRuleNames]::AssertRequestSemanticTokenMeaningfulness,
                $semanticIdentity,
                "'$($semanticName)' is required.",
                $traversalStrategy
            )
        }
        $this.DirectoryPath = $directoryPath
        $this.ChildNames = $childNames
        $this.FileFilter = $fileFilter
        $this.TraversalOptions = $traversalOptions
        $this.TraversalScope = $traversalScope
        $this.TraversalStrategy = $traversalStrategy
    }
    
}