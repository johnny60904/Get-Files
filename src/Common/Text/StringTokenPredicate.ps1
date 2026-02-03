class StringTokenPredicate {
    
    static  [bool] IsNullOrEmpty (
        [string] $value
    ) {
        return [System.String]::IsNullOrEmpty($value)
    }
    
    static [bool] IsNullOrWhiteSpace (
        [string] $value
    ) {
        return [System.String]::IsNullOrWhiteSpace($value)
    }
    
}