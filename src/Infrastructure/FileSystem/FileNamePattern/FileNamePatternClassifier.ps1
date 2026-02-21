class FileNamePatternClassifier {
    
    static [bool] IsUniversalWildcard (
        [string] $pattern
    ) {
        return (
            ([FileNamePatternPredicate]::IsWildcardWithAny($pattern)) -or 
            ([FileNamePatternPredicate]::IsWildcardAllNames($pattern))
        )
    }
    
    static [bool] IsConstraintedWildcard (
        [string] $pattern
    ) {
        return (
            ([FileNamePatternPredicate]::IsPrefixedWildcardWithDot($pattern)) -or 
            ([FileNamePatternPredicate]::IsDotWithSuffixedWildcard($pattern))
        )
    }
    
}