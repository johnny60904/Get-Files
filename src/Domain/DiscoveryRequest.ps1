class DiscoveryRequest {
    
    [string] $DirectoryPath
    [DiscoveryProfile] $DiscoveryProfile
    
    DiscoveryRequest ( # Shallow
        [string] $directoryPath,
        [DiscoveryProfile] $discoveryProfile
    ) {
        [DiscoveryRequestAssertions]::AssertDirectoryPathMeaningful($directoryPath)
        $this.DirectoryPath = $directoryPath
        $this.DiscoveryProfile = $discoveryProfile
    }
    
}