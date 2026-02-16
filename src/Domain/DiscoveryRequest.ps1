class DiscoveryRequest {
    
    [string] $DirectoryPath
    [string[]] $ChildNames
    [string] $FileFilter
    [TraversalOptions] $TraversalOptions
    [TraversalScope] $TraversalScope
    [TraversalStrategy] $TraversalStrategy
    
    DiscoveryRequest (
        [string] $directoryPath,
        [string[]] $childNames,
        [string] $fileFilter,
        [TraversalOptions] $traversalOptions,
        [TraversalScope] $traversalScope,
        [TraversalStrategy] $traversalStrategy
    ) {
        if ([System.String]::IsNullOrWhiteSpace($directoryPath)) {
            [string]$semanticName = ([DomainModelSemanticNames]::DirectoryPath).ToString()
            throw [DomainInvariantViolationException]::new(
                $semanticName,
                "'$($semanticName)' invalid (unmeaningfulness).",
                $directoryPath
            )
        }
        if ($childNames) {
            for ($i = 0; $i -lt $childNames.Length; $i ++) {
                if ([System.String]::IsNullOrWhiteSpace($childNames[$i])) {
                    [string]$semanticName = ([DomainModelSemanticNames]::ChildNames).ToString()
                    throw [DomainInvariantViolationException]::new(
                        $semanticName,
                        "'$($semanticName)' invalid (unmeaningfulness).",
                        $childNames[$i]
                    )
                }
            }
        }
        if ([System.String]::IsNullOrWhiteSpace($fileFilter)) {
            [string]$semanticName = ([DomainModelSemanticNames]::FileFilter).ToString()
            throw [DomainInvariantViolationException]::new(
                $semanticName,
                "'$($semanticName)' invalid (unmeaningfulness).",
                $fileFilter
            )
        }
        if (-not $traversalScope) {
            [string]$semanticName = ([DomainModelSemanticNames]::TraversalScope).ToString()
            throw [DomainInvariantViolationException]::new(
                $semanticName,
                "'$($semanticName)' invalid (unmeaningfulness).",
                $traversalScope
            )
        }
        if (-not $traversalStrategy) {
            [string]$semanticName = ([DomainModelSemanticNames]::TraversalStrategy).ToString()
            throw [DomainInvariantViolationException]::new(
                $semanticName,
                "'$($semanticName)' invalid (unmeaningfulness).",
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