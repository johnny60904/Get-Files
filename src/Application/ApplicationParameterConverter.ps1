class ApplicationParameterConverter {
    
    static [ApplicationParameter] FromDomainException (
        [DomainException] $exception
    ) {
        switch ($exception.SemanticName) {
            ([DomainModelSemanticNames]::DirectoryPath) {
                return [ApplicationParameter]::DirectoryPath
            }
            ([DomainModelSemanticNames]::ExcludeName) {
                return [ApplicationParameter]::ExcludeName
            }
            ([DomainModelSemanticNames]::ExcludeNames) {
                return [ApplicationParameter]::ExcludeNames
            }
            ([DomainModelSemanticNames]::FileFilter) {
                return [ApplicationParameter]::FileFilter
            }
            ([DomainModelSemanticNames]::TraversalOptions) {
                return [ApplicationParameter]::TraversalOptions
            }
            ([DomainModelSemanticNames]::TraversalScope) {
                return [ApplicationParameter]::TraversalScope
            }
            ([DomainModelSemanticNames]::TraversalStrategy) {
                return [ApplicationParameter]::TraversalStrategy
            }
            ([DomainModelSemanticNames]::NameCaseSensitivity) {
                return [ApplicationParameter]::NameCaseSensitivity
            }
            ([DomainModelSemanticNames]::SkipFileAttributes) {
                return [ApplicationParameter]::SkipFileAttributes
            }
            default {
                throw [System.InvalidOperationException]::new(
                    "Unknown identifier name for [DomainModelSemanticNames] in FromDomainException."
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            "Unreachable code path in FromDomainException."
        )
    }
    
}