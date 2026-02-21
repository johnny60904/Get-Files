class DiscoverStructuredFilesSet {
    
    hidden static [string] $UseCase = 'DiscoverStructuredFilesSet'
    
    [DiscoveryRequest] $DiscoveryRequest
    
    DiscoverStructuredFilesSet (
        [DiscoveryRequest] $discoveryRequest
    ) {
        $this.DiscoveryRequest = $discoveryRequest
    }
    
    # 使用者的 options 都是透過 DiscoveryOptionsFactory 獲得的,
    # DiscoveryOptionsFactory 就 Assert 過了, 所以這裡不再 Assert
    [ScriptBlock] Execute () {    
        # $DirectoryPath -> Resolve
        # Join / GetFullPath 不會噴錯
        # 但 GetFullPath 長度過長會噴錯
        try {
            [string]$resolvedPath = [IOPathResolver]::ResolvePath(
                $this.DiscoveryRequest.DirectoryPath
            )
        } catch {
            throw [UseCaseExecutionException]::new(
                [DiscoverStructuredFilesSet]::UseCase, # UseCaseName
                [ApplicationExceptionContext]::ResolveInputPaths, # Context
                [ApplicationExceptionReason]::ResolutionFailure, # Reason
                [ApplicationParameter]::InputPaths, # FieldName
                $_.Exception.TargetObject, # TargetObject
                "One or more input paths could not be resolved.", # Message
                $_.Exception # InnerException (bubbled from Infrastructue Layer)
            )
        }
        [IOFileDiscovery]$traversalEngine = [IOFileDiscovery]::new($this.DiscoveryRequest)
        try {
            return [IOFileDiscoveryStrategySelector]::Select(
                    $resolvedPath,
                    $traversalEngine
                )
        } catch {
            throw [UseCaseExecutionException]::new(
                [DiscoverStructuredFilesSet]::UseCase, # UseCaseName
                [ApplicationExceptionContext]::TraversalDirectories, # Context
                [ApplicationExceptionReason]::TraversalFailure, # Reason
                [ApplicationParameter]::TraversalOperation, # FieldName
                $_.Exception.TargetObject, # TargetObject
                "Failed to traverse the specified directories.", # Message
                $_.Exception # InnerException (bubbled from Infrastructue Layer)
            )
        }
    }
    
}