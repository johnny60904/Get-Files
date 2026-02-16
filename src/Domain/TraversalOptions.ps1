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
        if (-not $nameCaseSensitivity) {
            [string]$semanticName = ([DomainModelSemanticNames]::NameCaseSensitivity).ToString()
            throw [DomainInvariantViolationException]::new(
                $semanticName,
                "'$($semanticName)' invalid (unmeaningfulness).",
                $nameCaseSensitivity
            )
        }
        # EntryReadBufferSize 讓 Infrastructure 自己原生炸並向上冒泡給 Application 接收後再 wrap
        # EntryReadBufferSize [int] 和 [bool] 一樣, 不可能會有 null / whitespace 等 unpresent / unmeaningful 情況,
        # 因此不 assert (Application 也不 assert), 就留給 Infrastructure 原生炸 (若是無效的負數值的話)
        if (-not $skipFileAttributes) {
            [string]$semanticName = ([DomainModelSemanticNames]::SkipFileAttributes).ToString()
            throw [DomainInvariantViolationException]::new(
                $semanticName,
                "'$($semanticName)' invalid (unmeaningfulness).",
                $skipFileAttributes
            )
        }
        $this.SkipInaccessibleEntries = $skipInaccessibleEntries
        $this.NameCaseSensitivity = $nameCaseSensitivity
        $this.EntryReadBufferSize = $entryReadBufferSize
        $this.SkipFileAttributes = $skipFileAttributes
    }
    
}