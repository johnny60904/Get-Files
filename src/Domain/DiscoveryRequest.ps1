class DiscoveryRequest {
    
    [string] $DirectoryPath
    [DiscoveryProfile] $DiscoveryProfile
    
    DiscoveryRequest (
        [string] $directoryPath,
        [DiscoveryProfile] $discoveryProfile
    ) {
        [DiscoveryRequestAssertions]::AssertDirectoryPathMeaningful($directoryPath)
        $this.DirectoryPath = $directoryPath
        $this.DiscoveryProfile = $discoveryProfile
    }
    
}