class IOPathWindowsConstraints {
    
    # Windows filename reserved characters (cross-platform safe subset)
    hidden static [string[]] $ReservedTokens = @(
        '\', '/', ':', '*', '?', '"', '<', '>', '|'
    )
    
    # Windows reserved Dos device names
    hidden static [string[]] $SemanticReservedNames = @(
        'CON', 'PRN', 'AUX', 'NUL', 'COM1', 'COM2', 'COM3',
        'COM4', 'COM5', 'COM6', 'COM7', 'COM8', 'COM9', 'LPT1',
        'LPT2', 'LPT3', 'LPT4', 'LPT5', 'LPT6', 'LPT7', 'LPT8',
        'LPT9'
    )
    
    # 255 bytes (UTF-16 code units)
    hidden static [int] $SegmentMaxLengthLimit = 255
    
    hidden static [int] $LegacyMaxLengthLimit = 260
    
    hidden static [int] $LongPathMaxLengthLimit = 32767
    
    # default comparison rule
    hidden static [System.StringComparison] $DefaultComparison = [System.StringComparison]::OrdinalIgnoreCase
    
    static [string[]] GetInvalidTokens () {
        return [IOPathWindowsConstraints]::ReservedTokens       
    }
    
    static [string[]] GetExclusiveInvalidTokens () {
        return [IOPathWindowsConstraints]::SemanticReservedNames
    }
    
    static [int] GetSegmentMaxLengthLimit () {
        return [IOPathWindowsConstraints]::SegmentMaxLengthLimit
    }
    
    static [int] GetLegacyMaxLengthLimit () {
        return [IOPathWindowsConstraints]::LegacyMaxLengthLimit
    }
    
    static [int] GetMaxLengthLimit () {
        return [IOPathWindowsConstraints]::LongPathMaxLengthLimit
    }
    
    static [System.StringComparison] GetDefaultComparison () {
        return [IOPathWindowsConstraints]::DefaultComparison
    }
    
}