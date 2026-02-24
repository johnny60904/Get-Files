
class TraversalPolicyDefaults {
    
    hidden static [TraversalStrategy] $DefaultTraversalStrategy = [TraversalStrategy]::DepthFirst
    
    hidden static [int] $DefaultMaxDepthThresholdWhenRecurse = [System.Int32]::MaxValue
    
}