class UseCaseExecutionException : ApplicationException {
    
    [string] $UseCaseName
    [string] $Context
    [string] $Reason
    [string] $FieldName
    [object] $TargetObject
    
    UseCaseExecutionException (
        [string] $useCaseName,
        [string] $context,
        [string] $reason,
        [string] $fieldName,
        [object] $targetObject,
        [string] $message
    ) : base ($message) {
        $this.UseCaseName = $useCaseName
        $this.Context = $context
        $this.Reason = $reason
        $this.FieldName = $fieldName
        $this.TargetObject = $targetObject
    }
    
    UseCaseExecutionException (
        [string] $useCaseName,
        [string] $context,
        [string] $reason,
        [string] $fieldName,
        [object] $targetObject,
        [string] $message,
        [System.Exception] $innerException
    ) : base ($message, $innerException) {
        $this.UseCaseName = $useCaseName
        $this.Context = $context
        $this.Reason = $reason
        $this.FieldName = $fieldName
        $this.TargetObject = $targetObject
    }
    
}