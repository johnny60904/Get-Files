class IOPathSyntaxMacOSRule {
    
    static [bool] IsTerminalCharValid (
        [string] $value,
        [char[]] $invalidValues
    ) {
        return $true # MacOS 結尾 '.' / ' ' 均合法, 或是 Finder 會自動處理
    }
    
}