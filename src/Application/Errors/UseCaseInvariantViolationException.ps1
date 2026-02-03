class UseCaseInvariantViolationException : ApplicationException {
    
    [string] $ComponentName
    [string] $Context
    [string] $Reason
    
    UseCaseInvariantViolationException (
        [string] $componentName,
        [string] $context,
        [string] $reason,
        [string] $message
    ) : base ($message) {
        $this.ComponentName = $componentName
        $this.Context = $context
        $this.Reason = $reason
    }
    
    UseCaseInvariantViolationException (
        [string] $componentName,
        [string] $context,
        [string] $reason,
        [string] $message,
        [System.Exception] $innerException
    ) : base ($message, $innerException) {
        $this.ComponentName = $componentName
        $this.Context = $context
        $this.Reason = $reason
    }
    
}