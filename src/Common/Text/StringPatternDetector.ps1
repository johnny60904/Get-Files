class StringPatternDetector {
    
    static [bool] StartsWithAny (
        [string] $value,
        [string[]] $candidates
    ) {
        for ($i = 0; $i -lt $candidates.Length; $i ++) {
            if (($value.StartsWith($candidates[$i]))) {
                return $true
            }
        }
        return $false
    }
    
}