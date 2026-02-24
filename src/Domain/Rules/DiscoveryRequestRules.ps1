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
    
}