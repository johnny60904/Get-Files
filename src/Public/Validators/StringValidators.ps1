class StringValidators {
    
    static [void] ValidateNotNullOrWhiteSpace (
        [string] $val,
        [string] $parName
    ) {
        if ([System.String]::IsNullOrWhiteSpace($val)) {
            throw [System.ArgumentNullException]::new(
                $parName,
                "Value cannot be empty or null or whitespace."
            )
        }
    }
    
    static [void] ValidateIsOneOf (
        [string] $value,
        [string[]] $allowed,
        [System.StringComparison] $comparison,
        [string] $paramName
    ) {
        [StringValidators]::ValidateNotNullOrWhiteSpace($value, $paramName)
        [bool]$isAllowed = [StringTokenMatcher]::EqualsAny($value, $allowed, $comparison)
        if (-not $isAllowed) {
            [string]$allowedValuesDiagnostic = [ArgumentErrorDiagnosticFactory]::FormatAllowedValuesDiagnostic(
                $allowed,
                '',
                $comparison,
                "Value ({0}) must be: {1}."
            )
            throw [System.ArgumentOutOfRangeException]::new(
                $paramName,
                $value,
                "INVALID value (or is a stringified non-string, which means value is coerced into string): '$($value)'.   $($allowedValuesDiagnostic)."
            )
        }
    }
    
}