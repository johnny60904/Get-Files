class IOPathSegmentLengthMacOSEvaluator {
    
    static [int] Evaluate (
        [string] $value
    ) {
        return $value.Length
    }
    
}