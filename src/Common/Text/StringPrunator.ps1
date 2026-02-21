class StringPrunator {
    
    static [string] RemoveCandidateAndTrim (
        [string] $value,
        [string] $candidate
    ) {
        [int]$idx = $value.IndexOf($candidate)
        return $value.Remove($idx).Trim()
    }
    
}