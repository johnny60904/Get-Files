class FileNamePatternPredicate {
    
    static [bool] IsWildcardWithAny (
        [string] $pattern
    ) {
        return $pattern -eq ([FileWildcardPatterns]::AnyName) # *
    }
    
    static [bool] IsWildcardAllNames (
        [string] $pattern
    ) {
        return $pattern -eq ([FileWildcardPatterns]::AnyNameWithAnyExtension) # *.*
    }
    
    static [bool] IsPrefixedWildcardWithDot (
        [string] $pattern
    ) {
        # e.g. *.test.demo.txt
        return $pattern.StartsWith(
            [FileWildcardPatterns]::AnyNameWithDotPrefix # *.
        )
    }
    
    static [bool] IsDotWithSuffixedWildcard (
        [string] $pattern
    ) {
        # e.g. test.abc.txt.*
        return $pattern.EndsWith(
            [FileWildcardPatterns]::AnyExtension # .*
        )
    }
    
    static [bool] IsPathSeparatorContained (
        [string] $pattern
    ) {
        return ($pattern.IndexOfAny(
            [PathSeparatorTokens]::Tokens
        )) -ge 0
    }
    
    static [bool] IsRootedPathStructureContained (
        [string] $pattern
    ) {
        return [System.IO.Path]::IsPathRooted($pattern)
    }
    
    static [bool] IsEqualToDotDirectory (
        [string] $pattern
    ) {
        return (
            ($pattern -eq ([DirectoryNavigationTokens]::CurrentDirectoryToken)) -or 
            ($pattern -eq ([DirectoryNavigationTokens]::ParentDirectoryToken))
        )
    }
    
    static [bool] IsDotDirectoryContained (
        [string] $pattern
    ) {
        return [StringPatternDetector]::StartsWithAny(
            $pattern,
            [DirectoryNavigationTokenBuilder]::GetPrefixedNavidationTokens()
        )
    }
    
    static [bool] IsControlCharContained (
        [string] $pattern
    ) {
        [char[]]$chars = $pattern.ToCharArray()
        foreach ($char in $chars) {
            if ([System.Char]::IsControl($char)) {
                return $true
            }
        }
        return $false
    }
    
}