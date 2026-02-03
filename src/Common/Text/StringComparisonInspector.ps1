class StringComparisonInspector {
    
    static [bool] IsCaseInsensitive (
        [System.StringComparison] $comparison
    ) {
        switch ($comparison) {
            CurrentCulture { return $false }
            CurrentCultureIgnoreCase { return $true }
            InvariantCulture { return $false }
            InvariantCultureIgnoreCase { return $true }
            Ordinal { return $false }
            OrdinalIgnoreCase { return $true }
            default {
                throw [System.InvalidOperationException]::new(
                    'Unknown identifier name for [System.StringComparison] in IsCaseInsensitive.'
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in IsCaseInsensitive.'
        )
    }
    
    static [string] DescribeComparison (
        [System.StringComparison] $comparison
    ) {
        switch ($comparison) {
            CurrentCulture { return 'CaseSensitive-CultureSensitive' }
            CurrentCultureIgnoreCase { return 'CaseInsensitive-CultureSensitive' }
            InvariantCulture { return 'CaseSensitive-CultureSensitive(Linguistic)' }
            InvariantCultureIgnoreCase { return 'CaseInsensitive-CultureSensitive(Linguistic)' }
            Ordinal { return 'CaseSensitive-CultureInsensitive' }
            OrdinalIgnoreCase { return 'CaseInsensitive-CultureInsensitive' }
            default {
                throw [System.InvalidOperationException]::new(
                    'Unknown identifier name for [System.StringComparison] in DescribeComparison.'
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in DescribeComparison.'
        )
    }
    
    static [string] DescribeCaseSensitivity (
        [System.StringComparison] $comparison
    ) {
        switch ($comparison) {
            CurrentCulture { return 'CaseSensitive' }
            CurrentCultureIgnoreCase { return 'CaseInsensitive' }
            InvariantCulture { return 'CaseSensitive' }
            InvariantCultureIgnoreCase { return 'CaseInsensitive' }
            Ordinal { return 'CaseSensitive' }
            OrdinalIgnoreCase { return 'CaseInsensitive' }
            default {
                throw [System.InvalidOperationException]::new(
                    'Unknown identifier name for [System.StringComparison] in DescribeCaseSensitivity.'
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in DescribeCaseSensitivity.'
        )
    }
    
}