class DiscoverStructuredFilesSet {
    
    hidden static [string] $UseCase = 'DiscoverStructuredFilesSet'
    
    [IOFileDiscoveryStrategySelector] $TraversalStrategySelector
    
    DiscoverStructuredFilesSet (
        [IOFileDiscoveryStrategySelector] $traversalStrategySelector
    ) {
        $this.TraversalStrategySelector = $traversalStrategySelector
    }
    
    [ScriptBlock] Execute () {
        try {
            return $this.TraversalStrategySelector.Select()
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