class CharPatternDetector {
    
    static [bool] StartsWithAny (
        [string] $value,
        [char[]] $tokens
    ) {
        for ($i = 0; $i -lt $tokens.Length; $i ++) {
            if (($value.StartsWith($tokens[$i]))) {
                return $true
            }
        }
        return $false
    }
    
    static [bool] EndsWithAny (
        [string] $value,
        [char[]] $tokens
    ) {
        for ($i = 0; $i -lt $tokens.Length; $i ++) {
            if (($value.EndsWith($tokens[$i]))) {
                return $true
            }
        }
        return $false
    }
    
}