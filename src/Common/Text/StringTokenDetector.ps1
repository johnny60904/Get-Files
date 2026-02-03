class StringTokenDetector {
    
    static [int] IndexOfFirstOccurrence (
        [string] $value,
        [string[]] $tokens,
        [System.StringComparison] $comparison
    ) {
        [int]$min = -1
        for ($i = 0; $i -lt $tokens.Length; $i ++) {
            [int]$idx = $value.IndexOf($tokens[$i], $comparison)
            if ($idx -eq -1) { continue }
            if (($min -eq -1) -or ($idx -lt $min)) {
                $min = $idx
            }
        }
        return $min
    }
       
}