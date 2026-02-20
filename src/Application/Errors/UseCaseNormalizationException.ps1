class UseCaseNormalizationException : ApplicationException {
    
    [string] $ComponentName
    
    UseCaseNormalizationException (
        [string] $componentName,
        [ApplicationExceptionContext] $context,
        [ApplicationExceptionReason] $reason,
        [ApplicationParameter] $fieldName,
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
    
    UseCaseNormalizationException (
        [string] $componentName,
        [ApplicationExceptionContext] $context,
        [ApplicationExceptionReason] $reason,
        [ApplicationParameter] $fieldName,
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