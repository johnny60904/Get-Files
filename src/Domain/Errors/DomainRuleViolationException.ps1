class DomainRuleViolationException : DomainException {
    
    [DomainModelNames] $ModelName
    
    DomainRuleViolationException (
        [DomainModelNames] $modelName,
        [DomainRuleNames] $ruleName,
        [DomainModelSemanticNames] $semanticName,
        [string] $message,
        [object] $targetObject
    ) : base ($modelName, $ruleName, $semanticName, $message, $targetObject) {}
    
    DomainRuleViolationException (
        [DomainModelNames] $modelName,
        [DomainRuleNames] $ruleName,
        [DomainModelSemanticNames] $semanticName,
        [string] $message,
        [object] $targetObject,
        [System.Exception] $innerException
    ) : base ($modelName, $ruleName, $semanticName, $message, $targetObject, $innerException) {}
    
}