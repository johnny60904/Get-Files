class FileSystemNameMatcher {
    
    # value matches xxx (verb + xxx)
    static [bool] MatchesAnySimpleExpression ( # value matches any of the given patterns
        [string] $candidate,
        [string[]] $simpleExpressions,
        [bool] $isCaseSensitive
    ) {
        for ($i = 0; $i -lt $simpleExpressions.Length; $i ++) {
            if ([System.IO.Enumeration.FileSystemName]::MatchesSimpleExpression(
                $simpleExpressions[$i],
                $candidate,
                $isCaseSensitive
            )) {
                return $true
            }
        }
        return $false
    }
    
}