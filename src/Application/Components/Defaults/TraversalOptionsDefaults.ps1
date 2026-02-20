class TraversalOptionsDefaults {
    
    hidden static [bool] $SkipInaccessibleEntries = $true
    hidden static [NameCaseSensitivity] $NameCaseSensitivity = [NameCaseSensitivity]::Auto
    hidden static [int] $EntryReadBufferSize = 0
    hidden static [SkipFileAttributes] $SkipFileAttributes = (([SkipFileAttributes]::Hidden) -bor ([SkipFileAttributes]::System))
    
}