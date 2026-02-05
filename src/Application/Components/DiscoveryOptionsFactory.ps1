class DiscoveryOptionsFactory {
    
    hidden static [string] $Component = 'DiscoveryOptionsFactory'
    
    static [TraversalOptions] CreateDefaultOptions () {
        return [TraversalOptions]::new(
            [TraversalOptionsDefaults]::SkipInaccessibleEntries, # ContinueOnAccessDenied -> SkipInaccessibleEntries
            [TraversalOptionsDefaults]::EntryReadBufferSize, # IOBufferSize -> EntryReadBufferSize
            [TraversalOptionsDefaults]::SkipFileAttributes, # ExcludedFileAttributes -> SkipFileAttributes
            [TraversalOptionsDefaults]::NameCaseSensitivity # MatchCaseSensitivity -> NameCaseSensitivity
        )
    }
    
}