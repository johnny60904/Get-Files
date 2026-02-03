class DomainRuleViolationException : DomainException {
    
    [string] $RuleName
    
    DomainRuleViolationException (
        [string] $ruleName,
        [string] $message
    ) : base ($message) {
        $this.RuleName = $ruleName
    }
    
}