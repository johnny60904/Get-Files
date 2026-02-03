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
    
}