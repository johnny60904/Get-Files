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
        # $DirectoryPath + $ChildNames -> Join + Resolve
        # Join / GetFullPath 不會噴錯
        # 但 GetFullPath 長度過長會噴錯
        try {
            [System.Collections.Generic.IEnumerable[string]]$resolvedPathsBatch = [IOPathResolver]::ResolveChildPathsBatch(
                $this.DiscoveryRequest.DirectoryPath,
                $this.DiscoveryRequest.ChildNames
            )
        } catch {
            throw [UseCaseExecutionException]::new(
                [DiscoverStructuredFilesSet]::UseCase, # UseCaseName
                [ApplicationExceptionContext]::ResolveInputPaths, # Context
                [ApplicationExceptionReason]::ResolutionFailure, # Reason
                [ApplicationParameter]::InputPaths, # FieldName
                $_.Exception.TargetObject, # TargetObject
                "one or more input paths could not be resolved.", # Message
                $_.Exception # InnerException (bubbled from Infrastructue Layer)
            )
        }
        [IOFileDiscovery]$traversalEngine = [IOFileDiscovery]::new(
            $this.DiscoveryRequest.TraversalStrategy,
            $this.DiscoveryRequest.FileFilter,
            $this.DiscoveryRequest.TraversalOptions
        )
        try {
            return [IOFileDiscoveryStrategySelector]::Select(
                    $resolvedPathsBatch,
                    $this.DiscoveryRequest.TraversalScope,
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