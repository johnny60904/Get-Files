class DiscoveryRequestResolver {
    
    hidden static [string] $Component = 'DiscoveryRequestResolver'
    
    static [string] ResolveDirectoryPathRaw (
        [string] $directoryPath
    ) {
        try {
            return [IOPathResolver]::ResolvePath($directoryPath)
        } catch { # Infrastructure
            [ApplicationParameter]$semanticIdentity = [ApplicationParameter]::DirectoryPath
            [string]$semanticName = $semanticIdentity.ToString()
            throw [UseCaseResolvingException]::new(
                [DiscoveryRequestResolver]::Component, # ComponentName
                [ApplicationExceptionContext]::ResolveInputPath, # Context
                [ApplicationExceptionReason]::ResolutionFailure, # Reason
                $semanticIdentity, # FieldName
                $directoryPath, # TargetObject
                "$($semanticName) could not be resolved.", # Message
                $_.Exception # InnerException (Bubbled from Infrastructure)
            )
        }
    }
    
}