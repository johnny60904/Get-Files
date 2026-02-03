class TraversalOptions {
    
    [bool] $SkipInaccessibleEntries
    [int] $EntryReadBufferSize
    # Readonly, Hidden, System, Directory, Archive, Device,
    # Normal, Temporary, SparseFile, ReparsePoint, Compressed, Offline,
    # NotContentIndexed, Encrypted, IntegrityStream, NoScrubData
    [SkipFileAttributes] $SkipFileAttributes # @('Hidden', 'System')
    [NameCaseSensitivity] $NameCaseSensitivity # Auto, Sensitive, Insensitive
    
    TraversalOptions (
        [bool] $skipInaccessibleEntries,
        [int] $entryReadBufferSize,
        [SkipFileAttributes] $skipFileAttributes,
        [NameCaseSensitivity] $nameCaseSensitivity
    ) {
        $this.SkipInaccessibleEntries = $skipInaccessibleEntries
        $this.EntryReadBufferSize = $entryReadBufferSize
        $this.SkipFileAttributes = $skipFileAttributes
        $this.NameCaseSensitivity = $nameCaseSensitivity
    }
    
}