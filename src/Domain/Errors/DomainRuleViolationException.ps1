class DomainRuleViolationException : DomainException {
    
    [string] $RuleName
    
    DomainRuleViolationException (
        [string] $ruleName,
        [string] $message,
        [object] $targetObject
    ) : base ($message, $targetObject) {
        $this.RuleName = $ruleName
    }
    
    DomainRuleViolationException (
        [string] $ruleName,
        [string] $message,
        [object] $targetObject,
        [System.Exception] $innerException
    ) : base ($message, $targetObject, $innerException) {
        $this.RuleName = $ruleName
    }
    
}