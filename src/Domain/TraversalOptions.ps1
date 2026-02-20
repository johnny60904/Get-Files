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
        # EntryReadBufferSize 讓 Infrastructure 自己原生炸並向上冒泡給 Application 接收後再 wrap
        # EntryReadBufferSize [int] 和 [bool] 一樣, 不可能會有 null / whitespace 等 unpresent / unmeaningful 情況,
        # 因此不 assert (Application 也不 assert), 就留給 Infrastructure 原生炸 (若是無效的負數值的話)
        # 而 [NameCaseSensitivity] / [SkipFileAttributes] 已經是 Enum 了,
        # 加上 Domain Layer 的 Trust Boundary 是預設輸入都已經是 Domain Concept (合法) 了,
        # Enum 也和 bool 一樣, 就已經很原子了, 不可能會錯, 所以沒驗證
        # 若是 null, 在 Application Layer Translation 過程中就會噴 轉換 錯誤了
        # 只有合法 Domain Model 才給 Domain 使用
        $this.SkipInaccessibleEntries = $skipInaccessibleEntries
        $this.NameCaseSensitivity = $nameCaseSensitivity
        $this.EntryReadBufferSize = $entryReadBufferSize
        $this.SkipFileAttributes = $skipFileAttributes
    }
    
}