class DirectoryNavigationTokenBuilder {
    
    static [string[]] GetPrefixedNavidationTokens () {
        [string[]]$result = @(
            [StringComposer]::CombineAndTrim(
                ([PathSeparatorTokens]::DirectorySeparator).ToString(),
                [DirectoryNavigationTokens]::CurrentDirectoryToken
            ),
            [StringComposer]::CombineAndTrim(
                ([PathSeparatorTokens]::DirectorySeparator).ToString(),
                [DirectoryNavigationTokens]::CurrentDirectoryToken
            ),
            [StringComposer]::CombineAndTrim(
                ([PathSeparatorTokens]::AltDirectorySeparator).ToString(),
                [DirectoryNavigationTokens]::ParentDirectoryToken
            ),
            [StringComposer]::CombineAndTrim(
                ([PathSeparatorTokens]::AltDirectorySeparator).ToString(),
                [DirectoryNavigationTokens]::ParentDirectoryToken
            )
        )
        return [StringSetOperations]::Distinct($result) # deduplicate
    }
    
}