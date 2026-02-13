class UseCaseExecutionException : ApplicationException {
    
    [string] $UseCaseName
    
    UseCaseExecutionException (
        [string] $useCaseName,
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
        $this.UseCaseName = $useCaseName
    }
    
    UseCaseExecutionException (
        [string] $useCaseName,
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
        $this.UseCaseName = $useCaseName
    }
    
}