class UseCaseInvariantViolationException : ApplicationException {
    
    [string] $ComponentName
    
    UseCaseInvariantViolationException (
        [string] $componentName,
        [string] $context,
        [string] $reason,
        [string] $fieldName,
        [object] $targetObject,
        [string] $message
    ) : base (
        $message,
        $context,
        $reason,
        $fieldName,
        $targetObject
    ) {
        $this.ComponentName = $componentName
    }
    
    UseCaseInvariantViolationException (
        [string] $componentName,
        [string] $context,
        [string] $reason,
        [string] $fieldName,
        [object] $targetObject,
        [string] $message,
        [System.Exception] $innerException
    ) : base (
        $message,
        $context,
        $reason,
        $fieldName,
        $targetObject,
        $innerException
    ) {
        $this.ComponentName = $componentName
    }
    
}