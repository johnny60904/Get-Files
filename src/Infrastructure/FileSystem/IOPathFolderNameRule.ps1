class IOPathFolderNameRule {
    
    static [string] IsNullOrEmpty (
        [string] $value
    ) {
        return [System.String]::IsNullOrEmpty($value)
    }
    
}