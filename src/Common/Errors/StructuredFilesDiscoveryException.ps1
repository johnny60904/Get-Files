class StructuredFilesDiscoveryException : System.Exception {
    
    StructuredFilesDiscoveryException (
        [string] $message
    ) : base ($message) {}
    
    StructuredFilesDiscoveryException (
        [string] $message,
        [System.Exception] $innerException
    ) : base ($message, $innerException) {}
    
}