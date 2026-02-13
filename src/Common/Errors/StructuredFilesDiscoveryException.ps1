class StructuredFilesDiscoveryException : System.Exception {
    
    [object] $TargetObject
    
    StructuredFilesDiscoveryException (
        [string] $message,
        [object] $targetObject
    ) : base ($message) {
        $this.TargetObject = $targetObject
    }
    
    StructuredFilesDiscoveryException (
        [string] $message,
        [object] $targetObject,
        [System.Exception] $innerException
    ) : base ($message, $innerException) {
        $this.TargetObject = $targetObject
    }
    
}