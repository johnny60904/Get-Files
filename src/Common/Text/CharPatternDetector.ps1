class CharPatternDetector {
    
    static [bool] StartsWithAny (
        [string] $value,
        [char[]] $candidates
    ) {
        for ($i = 0; $i -lt $candidates.Length; $i ++) {
            if (($value.StartsWith($candidates[$i]))) {
                return $true
            }
        }
        return $false
    }
    
    static [bool] EndsWithAny (
        [string] $value,
        [char[]] $candidates
    ) {
        for ($i = 0; $i -lt $candidates.Length; $i ++) {
            if (($value.EndsWith($candidates[$i]))) {
                return $true
            }
        }
        return $false
    }
    
}