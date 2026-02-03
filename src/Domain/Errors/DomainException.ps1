class DomainException : StructuredFilesDiscoveryException {
    
    DomainException (
        [string] $message
    ) : base ($message) {}
    
    DomainException (
        [string] $message,
        [System.Exception] $innerException
    ) : base ($message, $innerException) {}
    
}