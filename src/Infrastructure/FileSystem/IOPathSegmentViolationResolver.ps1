class IOPathSegmentViolationResolver {
    
    static [string] ResolveExactExclusiveInvalidToken (
        [string] $value
    ) {
        [string]$normalized = [IOPathNormalizationResolver]::ResolveForSegment($value)
        [string[]]$exclusiveInvalidTokens = [IOPathConstraintsResolver]::ResolveExclusiveInvalidTokens()
        [System.StringComparison]$comparison = [IOPathConstraintsResolver]::ResolveDefaultComparison()
        return [StringTokenResolver]::ResolveExactCandidate(
            $normalized,
            $exclusiveInvalidTokens,
            $comparison
        )
    }
    
    static [bool] ResolveIsLengthValid (
        [string] $value
    ) {
        [int]$evaluated = [IOPathEvaluationResolver]::ResolveLengthForSegment($value)
        [int]$maxLengthLimit = [IOPathConstraintsResolver]::ResolveMaxLengthLimitForSegment()
        return ($evaluated -le $maxLengthLimit)
    }
    
}