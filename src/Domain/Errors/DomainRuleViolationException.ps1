class DomainRuleViolationException : DomainException {
    
    [string] $RuleName
    
    DomainRuleViolationException (
        [string] $ruleName,
        [object] $targetObject,
        [string] $message
    ) : base ($message, $targetObject) {
        $this.RuleName = $ruleName
    }
    
}