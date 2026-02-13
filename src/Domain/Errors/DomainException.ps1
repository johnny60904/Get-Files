class DomainException : StructuredFilesDiscoveryException {
    
    DomainException (
        [string] $message,
        [object] $targetObject
    ) : base ($message, $targetObject) {}
    
    DomainException (
        [string] $message,
        [object] $targetObject,
        [System.Exception] $innerException
    ) : base ($message, $targetObject, $innerException) {}
    
}