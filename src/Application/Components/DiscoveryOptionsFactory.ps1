class DiscoveryOptionsFactory {
    
    hidden static [string] $Component = 'DiscoveryOptionsFactory'
    
    static [TraversalOptions] CreateDefaultOptions () {
        return [TraversalOptions]::new(
            [TraversalOptionsDefaults]::SkipInaccessibleEntries, # ContinueOnAccessDenied -> SkipInaccessibleEntries
            [TraversalOptionsDefaults]::NameCaseSensitivity, # MatchCaseSensitivity -> NameCaseSensitivity
            [TraversalOptionsDefaults]::EntryReadBufferSize, # IOBufferSize -> EntryReadBufferSize
            [TraversalOptionsDefaults]::SkipFileAttributes # ExcludedFileAttributes -> SkipFileAttributes
        )
    }
    
}