class IOPathStructureWindowsRule {
    
    static [bool] IsQualifiedAbsolute (
        [string] $path
    ) {
        return [System.IO.Path]::IsPathFullyQualified($path)
    }
    
}