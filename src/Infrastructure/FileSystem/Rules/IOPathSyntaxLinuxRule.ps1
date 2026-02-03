class IOPathSyntaxLinuxRule {
    
    static [bool] IsTerminalCharValid (
        [string] $value,
        [char[]] $invalidValues
    ) {
        return $true # Linux 結尾 '.' / ' ' 均合法
    }
    
}