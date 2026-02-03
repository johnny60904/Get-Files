class IOPathSegmentWindowsNormalizer {
    
    static [string] Normalize (
        [string] $value
    ) {
        # for Dos names validation
        return [System.IO.Path]::GetFileNameWithOutExtension($value)
    }
    
}