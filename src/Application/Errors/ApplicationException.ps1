class ApplicationException : StructuredFilesDiscoveryException {
    
    [ApplicationExceptionContext] $Context
    [ApplicationExceptionReason] $Reason
    [ApplicationParameter] $FieldName
    
    ApplicationException (
        [string] $message,
        [ApplicationExceptionContext] $context,
        [ApplicationExceptionReason] $reason,
        [ApplicationParameter] $fieldName,
        [object] $targetObject
    ) : base ($message, $targetObject) {
        $this.Context = $context
        $this.Reason = $reason
        $this.FieldName = $fieldName
    }
    
    ApplicationException (
        [string] $message,
        [ApplicationExceptionContext] $context,
        [ApplicationExceptionReason] $reason,
        [ApplicationParameter] $fieldName,
        [object] $targetObject,
        [System.Exception] $innerException
    ) : base ($message, $targetObject, $innerException) {
        $this.Context = $context
        $this.Reason = $reason
        $this.FieldName = $fieldName
    }
    
}