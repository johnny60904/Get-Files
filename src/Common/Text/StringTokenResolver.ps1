class StringTokenResolver {
    
    # 只要包含就算
    static [string] ResolveFirstContainedCandidate (
        [string] $value,
        [string[]] $candidates,
        [System.StringComparison] $comparison
    ) {
        [int]$firstIndex = -1
        $matched = $null
        for ($i = 0; $i -lt $candidates.Length; $i ++) {
            [string]$candidate = $candidates[$i]
            [int]$idx = $value.IndexOf($candidate, $comparison)
            if ($idx -eq -1) { continue }
            if (($firstIndex -eq -1) -or ($idx -lt $firstIndex)) {
                [int]$firstIndex = $idx
                [string]$matched = $candidate
            }
        }
        return $matched
    }
    
    # 必須剛剛好, 如 $candidates = @('AB', 'CD'), $value = 'testaBcD' -> X; $value = 'aB' -> V
    static [string] ResolveExactCandidate (
        [string] $value,
        [string[]] $candidates,
        [System.StringComparison] $comparison
    ) {
        for ($i = 0; $i -lt $candidates.Length; $i ++) {
            [string]$candidate = $candidates[$i]
            if (($candidate.Equals($value, $comparison))) {
                return $candidate
            }
        }
        return $null
    }
    
}