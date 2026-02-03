class ExclusiveFileFilterPatternPredicate {
    
    # special case (valid)
    static [bool] IsWildcardAllNamesPattern (
        [string] $value
    ) {
        return $value -eq '*.*'
    }
    
    # special case (valid)
    static [bool] IsWildcardNamePrefixPattern (
        [string] $value
    ) {
        return $value.StartsWith('*.') # e.g. *.test.*
    }
    
    # special case (valid)
    static [bool] IsWildcardExtensionPattern (
        [string] $value
    ) {
        return $value.EndsWith('.*') # e.g. *.*.txt
    }
    
    static [bool] IsExclusiveFileFilterPattern (
        [string] $value
    ) {
        return (
            ([ExclusiveFileFilterPatternPredicate]::IsWildcardAllNamesPattern($value)) -or 
            ([ExclusiveFileFilterPatternPredicate]::IsWildcardNamePrefixPattern($value)) -or 
            ([ExclusiveFileFilterPatternPredicate]::IsWildcardExtensionPattern($value))
        )
    }
    
}