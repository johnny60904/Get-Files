class FileNamePatternTransformer { # extract file name from a file name pattern (e.g. file filter)
    
    static [string] ExtractFileName (
        [string] $pattern
    ) {
        return [System.IO.Path]::GetFileName($pattern)
    }
    
    # extract file name 排除特定起端
    static [string] TrimPrefix ( # e.g. '*.demo.test.abc' -> demo.test.abc
        [string] $pattern,
        [string] $prefix
    ) {
        return $pattern.SubString($prefix.Length)
    }
    
    # extract file name 排除特定尾端
    static [string] TrimSuffix ( # e.g. 'demo.test.abc.*' -> demo.test.abc
        [string] $pattern,
        [string] $suffix
    ) {
        [int]$suffixIdx = $pattern.IndexOf($suffix)
        return $pattern.Remove($suffixIdx, $pattern.Length)
    }
    
}