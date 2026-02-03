class IOTraversalOptionsConverter {
    
    static [System.IO.EnumerationOptions] ToEnumerationOptions (
        [TraversalOptions] $traversalOptions
    ) {
        return [System.IO.EnumerationOptions]@{
            RecurseSubdirectories = [DirectoryEnumerationPreset]::IncludeSubdirectories
            IgnoreInaccessible = $traversalOptions.SkipInaccessibleEntries
            BufferSize = $traversalOptions.EntryReadBufferSize
            AttributesToSkip = [SkipFileAttributesConverter]::ToFileAttributes($traversalOptions.SkipFileAttributes)
            MatchType = [DirectoryEnumerationPreset]::PatternMatchStrategy
            MatchCasing = [NameCaseSensitivityConverter]::ToMatchCasing($traversalOptions.NameCaseSensitivity)
            MaxRecursionDepth =[DirectoryEnumerationPreset]::MaxRecursionDepth
            ReturnSpecialDirectories = [DirectoryEnumerationPreset]::IncludeDotDirectories
        }
    }
    
}