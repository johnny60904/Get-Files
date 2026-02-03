class IOPathStructureMacOSRule {
    
    static [bool] IsQualifiedAbsolute (
        [string] $path
    ) {
        return [CharPatternDetector]::StartsWithAny($path, [char[]]@('/'))
    }
    
}