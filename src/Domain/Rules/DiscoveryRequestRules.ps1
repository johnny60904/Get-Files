class DiscoveryRequestRules {
    
    static [bool] IsDirectoryPathMeaningful (
        [string] $directoryPath
    ) {
        if ([System.String]::IsNullOrWhiteSpace($directoryPath)) {
            return $false
        } else {
            return $true
        }
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
    
    static [bool] IsShallowRequest (
        [TraversalScope] $traversalScope
    ) {
        if ($traversalScope -eq ([TraversalScope]::Shallow)) {
            return $true
        } else {
            return $false
        }
    }
    
    static [bool] IsRecursiveRequest (
        [TraversalScope] $traversalScope
    ) {
        if ($traversalScope -eq ([TraversalScope]::Recurse)) {
            return $true
        } else {
            return $false
        }
    }
    
}