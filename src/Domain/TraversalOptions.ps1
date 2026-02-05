class TraversalOptions {
    
    [bool] $SkipInaccessibleEntries
    [NameCaseSensitivity] $NameCaseSensitivity # Auto, Sensitive, Insensitive
    [int] $EntryReadBufferSize
    # Readonly, Hidden, System, Directory, Archive, Device,
    # Normal, Temporary, SparseFile, ReparsePoint, Compressed, Offline,
    # NotContentIndexed, Encrypted, IntegrityStream, NoScrubData
    [SkipFileAttributes] $SkipFileAttributes # @('Hidden', 'System')
    
    TraversalOptions (
        [bool] $skipInaccessibleEntries,
        [NameCaseSensitivity] $nameCaseSensitivity,
        [int] $entryReadBufferSize,
        [SkipFileAttributes] $skipFileAttributes
    ) {
        $this.SkipInaccessibleEntries = $skipInaccessibleEntries
        $this.NameCaseSensitivity = $nameCaseSensitivity
        $this.EntryReadBufferSize = $entryReadBufferSize
        $this.SkipFileAttributes = $skipFileAttributes
    }
    
}