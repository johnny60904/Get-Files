class UseCaseExecutionException : ApplicationException {
    
    [string] $UseCaseName
    [string] $Context
    [string] $Reason
    
    UseCaseExecutionException (
        [string] $useCaseName,
        [string] $context,
        [string] $reason,
        [string] $message
    ) : base ($message) {
        $this.UseCaseName = $useCaseName
        $this.Context = $context
        $this.Reason = $reason
    }
    
    UseCaseExecutionException (
        [string] $useCaseName,
        [string] $context,
        [string] $reason,
        [string] $message,
        [System.Exception] $innerException
    ) : base ($message, $innerException) {
        $this.UseCaseName = $useCaseName
        $this.Context = $context
        $this.Reason = $reason
    }
    
}