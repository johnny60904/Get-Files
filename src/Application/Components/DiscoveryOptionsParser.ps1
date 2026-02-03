class DiscoveryOptionsParser {
    
    hidden static [string] $Component = 'DiscoveryOptionsParser'
    
    static [bool] TryParseSkipFileAttribute (
        [string] $value,
        [bool] $ignoreCase,
        [ref] $result
    ) {
        return [System.Enum]::TryParse(
            [SkipFileAttributes],
            $value,
            $ignoreCase,
            $result
        )
    }
    
    static [bool] TryParseSkipFileAttributes (
        [string[]] $values,
        [bool] $ignoreCase,
        [ref] $Result,
        [ref] $InvalidValue
    ) {
        [int]$flag = 0
        for ($i = 0; $i -lt $values.Length; $i ++) {
            [string]$value = $values[$i]
            $parsed = $null
            if (-not ([DiscoveryOptionsParser]::TryParseSkipFileAttribute($value, $ignoreCase, [ref]$parsed))) {
                $InvalidValue.Value = $value
                return $false
            }
            [int]$flag = $flag -bor ([int] $parsed)
        }
        $Result.Value = $flag
        return $true
    }
    
    static [bool] TryParseNameCaseSensitivity (
        [string] $value,
        [bool] $ignoreCase,
        [ref] $result
    ) {
        return [System.Enum]::TryParse(
            [NameCaseSensitivity],
            $value,
            $ignoreCase,
            $result
        )
    }
    
    static [SkipFileAttributes] ParseSkipFileAttributes (
        [string[]] $collection,
        [System.StringComparison] $comparison
    ) {
        [string]$collectionSemanticName = ([ApplicationSemanticNames]::SkipFileAttributes).ToString()
        if ($null -eq $collection) {
            throw [UseCaseParsingException]::new(
                [DiscoveryOptionsParser]::Component, # ComponentName
                ([ApplicationExceptionContext]::AssertSemanticTokenCollectionPresence).ToString(), # Context
                ([ApplicationExceptionReason]::SemanticTokenCollectionIsNull).ToString(), # Reason
                "$($collectionSemanticName) must not be null." # Message
            )
        }
        if ($collection.Length -eq 0) {
            throw [UseCaseParsingException]::new(
                [DiscoveryOptionsParser]::Component, # ComponentName
                ([ApplicationExceptionContext]::AssertSemanticTokenCollectionMeaningfulness).ToString(), # Context
                ([ApplicationExceptionReason]::SemanticTokenCollectionIsEmpty).ToString(), # Reason
                "$($collectionSemanticName) must not be empty." # Message
            )
        }
        [string]$semanticName = ([ApplicationSemanticNames]::SkipFileAttribute).ToString()
        for ($i = 0; $i -lt $collection.Length; $i ++) {
            [string]$item = $collection[$i]
            if ([System.String]::IsNullOrWhiteSpace($item)) {
                throw [UseCaseParsingException]::new(
                    [DiscoveryOptionsParser]::Component, # ComponentName
                    ([ApplicationExceptionContext]::AssertSemanticTokenMeaningfulness).ToString(), # Context
                    ([ApplicationExceptionReason]::SemanticTokenNullOrWhiteSpace).ToString(), # Reason
                    "$($semanticName) must not be null, empty, or whitespace." # Message
                )
            }
        }
        [bool]$isCaseInsensitive = [StringComparisonInspector]::IsCaseInsensitive($comparison)
        $parsed = $null
        $invalid = $null
        [bool]$isValid = [DiscoveryOptionsParser]::TryParseSkipFileAttributes(
            $collection,
            $isCaseInsensitive,
            [ref]$parsed,
            [ref]$invalid
        )
        if (-not $isValid) {
            throw [UseCaseParsingException]::new(
                [DiscoveryOptionsParser]::Component, # ComponentName
                ([ApplicationExceptionContext]::TranslateSemanticTokenToDomainValue).ToString(), # Context
                ([ApplicationExceptionReason]::SemanticTokenTranslationFailure).ToString(), # Reason
                "$($semanticName) is not a valid domain-supported value: '$($invalid)'." # Message
            )
        }
        return $parsed
    }
    
    static [NameCaseSensitivity] ParseNameCaseSensitivity (
        [string] $value,
        [System.StringComparison] $comparison
    ) {
        [string]$semanticName = ([ApplicationSemanticNames]::NameCaseSensitivity).ToString()
        if ([System.String]::IsNullOrWhiteSpace($value)) {
            throw [UseCaseParsingException]::new(
                [DiscoveryOptionsParser]::Component, # ComponentName
                ([ApplicationExceptionContext]::AssertSemanticTokenMeaningfulness).ToString(), # Context
                ([ApplicationExceptionReason]::SemanticTokenNullOrWhiteSpace).ToString(), # Reason
                "$($semanticName) must not be null, empty, or whitespace." # Message
            )
        }
        [bool]$isCaseInsensitive = [StringComparisonInspector]::IsCaseInsensitive($comparison)
        $parsed = $null
        [bool]$isValid = [DiscoveryOptionsParser]::TryParseNameCaseSensitivity(
            $value,
            $isCaseInsensitive,
            [ref]$parsed
        )
        if (-not $isValid) {
            throw [UseCaseParsingException]::new(
                [DiscoveryOptionsParser]::Component, # ComponentName
                ([ApplicationExceptionContext]::TranslateSemanticTokenToDomainValue).ToString(), # Context
                ([ApplicationExceptionReason]::SemanticTokenTranslationFailure).ToString(), # Reason
                "$($semanticName) is not a valid domain-supported value: '$($value)'." # Message
            )
        }
        return $parsed
    }
    
}