class ApplicationException : StructuredFilesDiscoveryException {
    
    [string] $Context
    [string] $Reason
    [string] $FieldName
    
    ApplicationException (
        [string] $message,
        [string] $context,
        [string] $reason,
        [string] $fieldName,
        [object] $targetObject
    ) : base ($message, $targetObject) {
        $this.Context = $context
        $this.Reason = $reason
        $this.FieldName = $fieldName
    }
    
    ApplicationException (
        [string] $message,
        [string] $context,
        [string] $reason,
        [string] $fieldName,
        [object] $targetObject,
        [System.Exception] $innerException
    ) : base ($message, $targetObject, $innerException) {
        $this.Context = $context
        $this.Reason = $reason
        $this.FieldName = $fieldName
    }
    
}