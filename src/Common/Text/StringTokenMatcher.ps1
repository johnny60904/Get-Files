class StringTokenMatcher {
    
    static [bool] EqualsAny (
        [string] $value,
        [string[]] $candidates,
        [System.StringComparison] $comparison
    ) {
        for ($i = 0; $i -lt $candidates.Length; $i ++) {
            if ((($candidates[$i]).Equals($value, $comparison))) {
                return $true
            }
        }
        return $false
    }
    
}