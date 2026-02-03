class IOPathViolationResolver {
    
    static [string] ResolveFirstContainedInvalidToken (
        [string] $value
    ) {
        [string[]]$invalidTokens = [IOPathConstraintsResolver]::ResolveInvalidTokens()
        [System.StringComparison]$comparison = [IOPathConstraintsResolver]::ResolveDefaultComparison()
        return [StringTokenResolver]::ResolveFirstContainedCandidate(
            $value,
            $invalidTokens,
            $comparison
        )
    }
    
    static [bool] ResolveIsLengthValid (
        [string] $value
    ) {
        [int]$length = $value.Length
        [int]$maxLengthLimit = [IOPathMaxLengthResolver]::ResolveEffectiveMaxLength()
        return ($length -le $maxLengthLimit)
    }
    
}