class DomainInvariantViolationException : DomainException {
    
    [string] $FieldName
    
    DomainInvariantViolationException (
        [string] $fieldName,
        [string] $message,
        [object] $targetObject
    ) : base ($message, $targetObject) {
        $this.FieldName = $fieldName
    }
    
    DomainInvariantViolationException (
        [string] $fieldName,
        [string] $message,
        [object] $targetObject,
        [System.Exception] $innerException
    ) : base ($message, $targetObject, $innerException) {
        $this.FieldName = $fieldName
    }
    
}