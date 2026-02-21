class StringPatternDetector {
    
    static [bool] StartsWithAny (
        [string] $value,
        [string[]] $tokens
    ) {
        for ($i = 0; $i -lt $tokens.Length; $i ++) {
            if (($value.StartsWith($tokens[$i]))) {
                return $true
            }
        }
        return $false
    }
    
}