class NumericValidators {
    
    static [void] ValidateNonNegtiveInteger (
        [int] $value,
        [string] $paramName
    ) {
        if ($value -lt 0) {
            throw [System.ArgumentOutOfRangeException]::new(
                $paramName,
                $value,
                "Value must be >= 0.   Value: $($value)."
            )
        }
    }
    
    static [void] ValidatePositiveInteger (
        [int] $value,
        [string] $paramName
    ) {
        if ($value -le 0) {
            throw [System.ArgumentOutOfRangeException]::new(
                $paramName,
                $value,
                "Value must be > 0.   Value: $($value)."
            )
        }
    }
    
    static [void] ValidateIntegerIsWithinAllowedRange (
        [int] $value,
        [int] $min,
        [int] $max,
        [string] $paramName
    ) {
        if (-not (($value -ge $min) -and ($value -le $max))) {
            throw [System.ArgumentOutOfRangeException]::new(
                $paramName,
                $value,
                "Value must be within $($min) to $($max).   Value: $($value)."
            )
        }
    }
    
}