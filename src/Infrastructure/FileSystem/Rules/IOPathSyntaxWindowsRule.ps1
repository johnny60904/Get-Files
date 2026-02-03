class IOPathSyntaxWindowsRule {
    
    static [bool] IsTerminalCharValid (
        [string] $value,
        [char[]] $invalidValues
    ) {
        # 不可空白或 . 結尾 (Windows NTFS 硬限制)
        return (-not ([CharPatternDetector]::EndsWithAny($value, $invalidValues)))
    }
    
}