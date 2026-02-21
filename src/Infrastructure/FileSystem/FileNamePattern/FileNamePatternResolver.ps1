class FileNamePatternResolver {
    
    static [string] ResolveFirstContainedDirectorySeparator (
        [string] $pattern
    ) {
        [int]$idx = $pattern.IndexOfAny([PathSeparatorTokens]::Tokens)
        if ($idx -ge 0) {
            return ($pattern[$idx])
        } else {
            return $null
        }
    }
    
    static [string] ResolveFirstContainedDotDirectory (
        [string] $pattern
    ) {
        return [StringTokenResolver]::ResolveFirstContainedCandidate(
            $pattern,
            [DirectoryNavigationTokenBuilder]::GetPrefixedNavidationTokens(),
            [StringComparisonDefault]::Default
        )
    }
    
    static [string] ResolveFirstContainedControlChar (
        [string] $pattern
    ) {
        [int]$idx = -1
        [char[]]$chars = $pattern.ToCharArray()
        foreach ($char in $chars) {
            $idx++
            if ([System.Char]::IsControl($char)) {
                return ($pattern[$idx])
            }
        }
        return $null
    }
    
}