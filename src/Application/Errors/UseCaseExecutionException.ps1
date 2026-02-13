class UseCaseExecutionException : ApplicationException {
    
    [string] $UseCaseName
    
    UseCaseExecutionException (
        [string] $useCaseName,
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
        $this.UseCaseName = $useCaseName
    }
    
    UseCaseExecutionException (
        [string] $useCaseName,
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
        $this.UseCaseName = $useCaseName
    }
    
}