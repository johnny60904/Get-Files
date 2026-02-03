class IOPathSegmentLengthWindowsEvaluator {
    
    static [int] Evaluate (
        [string] $value
    ) {
        return $value.Length
    }
    
}