class FileFilterExtractor {
    
    static [string] ExtractFileName (
        [string] $value
    ) {
        return [System.IO.Path]::GetFileName($value)
    }
    
}