class DomainRuleViolationException : DomainException {
    
    [string] $RuleName
    [object] $TargetObject
    
    DomainRuleViolationException (
        [string] $ruleName,
        [object] $targetObject,
        [string] $message
    ) : base ($message) {
        $this.RuleName = $ruleName
        $this.TargetObject = $targetObject
    }
    
}