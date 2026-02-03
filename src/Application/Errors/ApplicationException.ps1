class ApplicationException : StructuredFilesDiscoveryException {
    
    ApplicationException (
        [string] $message
    ) : base ($message) {}
    
    ApplicationException (
        [string] $message,
        [System.Exception] $innerException
    ) : base ($message, $innerException) {}
    
}