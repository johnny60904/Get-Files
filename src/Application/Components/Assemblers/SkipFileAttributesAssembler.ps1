class SkipFileAttributesAssembler {
    
    static [SkipFileAttributes] ResolveHidden (
        [bool] $hidden
    ) {
        if ($hidden) {
            return [SkipFileAttributes]::Hidden
        } else {
            return [SkipFileAttributes]::None
        }
    }
    
    static [SkipFileAttributes] ResolveSystem (
        [bool] $system
    ) {
        if ($system) {
            return [SkipFileAttributes]::System
        } else {
            return [SkipFileAttributes]::None
        }
    }
    
    static [SkipFileAttributes] ResolveReadOnly (
        [bool] $readOnly
    ) {
        if ($readOnly) {
            return [SkipFileAttributes]::ReadOnly
        } else {
            return [SkipFileAttributes]::None
        }
    }
    
}