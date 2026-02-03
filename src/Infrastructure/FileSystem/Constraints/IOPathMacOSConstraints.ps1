class IOPathMacOSConstraints {
    
    # MacOS filename reserved characters
    hidden static [string[]] $ReservedTokens = @('/', '`0') # \0
    
    # MacOS reserved semantic characters
    hidden static [string[]] $SemanticReservedNames = @('.', '..')
    
    # MacOS Finder Invalid characters
    hidden static [string[]] $FinderInvalidTokens = @(':')
    
    # 255 bytes (UTF-16 code units)
    hidden static [int] $SegmentMaxLengthLimit = 255
    
    hidden static [int] $MaxLengthLimit = 1024
    
    # default comparison rule
    hidden static [System.StringComparison] $DefaultComparison = [System.StringComparison]::OrdinalIgnoreCase
    
    static [string[]] GetInvalidTokens () {
        return [CollectionsMerger]::ConcatStringArray(
            [IOPathMacOSConstraints]::ReservedTokens,
            [IOPathMacOSConstraints]::SemanticReservedNames,
            [IOPathMacOSConstraints]::FinderInvalidTokens
        )
    }
    
    static [string[]] GetExclusiveInvalidTokens () {
        return $null
    }
    
    static [int] GetSegmentMaxLengthLimit () {
        return [IOPathMacOSConstraints]::SegmentMaxLengthLimit
    }
    
    static [int] GetMaxLengthLimit () {
        return [IOPathMacOSConstraints]::MaxLengthLimit
    }
    
    static [System.StringComparison] GetDefaultComparison () {
        return [IOPathMacOSConstraints]::DefaultComparison
    }
    
}