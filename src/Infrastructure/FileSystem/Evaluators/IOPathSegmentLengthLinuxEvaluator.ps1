class IOPathSegmentLengthLinuxEvaluator {
    
    static [int] Evaluate (
        [string] $value
    ) {
        return [System.Text.Encoding]::UTF8.GetByteCount($value)
    }
    
}