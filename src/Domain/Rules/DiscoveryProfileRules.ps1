class DiscoveryProfileRules {
    
    static [bool] IsExcludeNamesAllowedAbsence (
        [string[]] $excludeNames
    ) {
        if (($null -eq $excludeNames) -or ($excludeNames.Length -eq 0)) {
            return $true
        } else {
            return $false
        }
    }
    
    static [bool] IsExcludeNamesMeaningful (
        [string[]] $excludeNames
    ) {
        for ($i = 0; $i -lt $excludeNames.Length; $i ++) {
            if ([System.String]::IsNullOrWhiteSpace($excludeNames[$i])) {
                return $false
            }
        }
        return $true
    }
    
    static [bool] IsFileFilterMeaningful (
        [string] $fileFilter
    ) {
        if ([System.String]::IsNullOrWhiteSpace($fileFilter)) {
            return $false
        } else {
            return $true
        }
    }
    
    static [bool] IsShallowProfile (
        [TraversalScope] $traversalScope
    ) {
        if (-not ($traversalScope -eq ([TraversalScope]::Shallow))) {
            return $false
        } else {
            return $true
        }
    }
    
    static [bool] IsRecursiveProfile (
        [TraversalScope] $traversalScope
    ) {
        if (-not ($traversalScope -eq ([TraversalScope]::Recurse))) {
            return $false
        } else {
            return $true
        }
    }
    
}