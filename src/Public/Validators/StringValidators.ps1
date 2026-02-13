class StringValidators {
    
    static [void] ValidateIsRequired (
        [string] $value,
        [string] $paramName
    ) {
        if ([System.String]::IsNullOrWhiteSpace($value)) {
            throw [System.ArgumentNullException]::new(
                $paramName,
                "Value UNPROVIDED (empty, null, or whitespace).   Please provide a valid value and try again."
            )
        }
    }
    
    static [void] ValidateAllowedAbsence (
        [string] $value
    ) {
        if ([System.String]::IsNullOrEmpty($value)) { return }
    }
    
    static [void] ValidateIsOneOf (
        [string] $value,
        [string[]] $allowed,
        [System.StringComparison] $comparison,
        [string] $paramName
    ) {
        [StringValidators]::ValidateIsRequired($value, $paramName)
        [bool]$isAllowed = [StringTokenMatcher]::EqualsAny($value, $allowed, $comparison)
        if (-not $isAllowed) {
            [string]$allowedValuesDiagnostic = [ArgumentErrorDiagnosticFormatter]::FormatAllowedValuesDiagnostic(
                $allowed,
                '',
                $comparison,
                "Valid values ({0}): {1}." # CaseSensitivity  / Valid Values
            )
            throw [System.ArgumentOutOfRangeException]::new(
                $paramName,
                $value,
                "INVALID value (or is a stringified non-string, which means value is coerced into string): '$($value)'.   $($allowedValuesDiagnostic)."
            )
        }
    }
    
}