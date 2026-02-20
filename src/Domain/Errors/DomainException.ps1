class DomainException : StructuredFilesDiscoveryException {
    
    [DomainModelNames] $ModelName
    [DomainRuleNames] $RuleName
    [DomainModelSemanticNames] $SemanticName
    
    DomainException (
        [DomainModelNames] $modelName,
        [DomainRuleNames] $ruleName,
        [DomainModelSemanticNames] $semanticName,
        [string] $message,
        [object] $targetObject
    ) : base ($message, $targetObject) {
        $this.ModelName = $modelName
        $this.RuleName = $ruleName
        $this.SemanticName = $semanticName
    }
    
    DomainException (
        [DomainModelNames] $modelName,
        [DomainRuleNames] $ruleName,
        [DomainModelSemanticNames] $semanticName,
        [string] $message,
        [object] $targetObject,
        [System.Exception] $innerException
    ) : base ($message, $targetObject, $innerException) {
        $this.ModelName = $modelName
        $this.RuleName = $ruleName
        $this.SemanticName = $semanticName
    }
    
}