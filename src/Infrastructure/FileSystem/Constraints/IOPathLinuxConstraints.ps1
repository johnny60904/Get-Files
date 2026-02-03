class IOPathLinuxConstraints {
    
    # Linux filename reserved characters
    hidden static [string[]] $ReservedTokens = @('/', '`0') # \0
    
    # Linux reserved semantic characters
    hidden static [string[]] $SemanticReservedNames = @('.', '..')
    
    # 255 bytes (UTF-8 bytes)
    hidden static [int] $SegmentMaxLengthLimit = 255
    
    hidden static [int] $MaxLengthLimit = 4096
    
    # default comparison rule
    hidden static [System.StringComparison] $DefaultComparison = [System.StringComparison]::OrdinalIgnoreCase
    
    static [string[]] GetInvalidTokens () {
        return [CollectionsMerger]::ConcatStringArray(
            [IOPathLinuxConstraints]::ReservedTokens,
            [IOPathLinuxConstraints]::SemanticReservedNames
        )
    }
    
    static [string[]] GetExclusiveInvalidTokens () {
        return $null
    }
    
    static [int] GetSegmentMaxLengthLimit () {
        return [IOPathLinuxConstraints]::SegmentMaxLengthLimit
    }
    
    static [int] GetMaxLengthLimit () {
        return [IOPathLinuxConstraints]::MaxLengthLimit
    }
    
    static [System.StringComparison] GetDefaultComparison () {
        return [IOPathLinuxConstraints]::DefaultComparison
    }
    
}