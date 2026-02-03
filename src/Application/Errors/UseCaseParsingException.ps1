class UseCaseParsingException : ApplicationException {
    
    [string] $ComponentName
    [string] $Context
    [string] $Reason
    
    UseCaseParsingException (
        [string] $componentName,
        [string] $context,
        [string] $reason,
        [string] $message
    ) : base ($message) {
        $this.ComponentName = $componentName
        $this.Context = $context
        $this.Reason = $reason
    }
    
    UseCaseParsingException (
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