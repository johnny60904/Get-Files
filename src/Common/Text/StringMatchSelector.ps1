class StringMatchSelector {
    
    static [string] SelectIfEqual (
        [string] $actual,
        [string] $expected,
        [System.StringComparison] $comparison,
        [string] $value
    ) {
        if ([System.String]::Equals($actual, $expected, $comparison)) {
            return $value
        } else {
            return $null
        }
    }
    
}