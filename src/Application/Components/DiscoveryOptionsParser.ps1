class DiscoveryOptionsParser {
    
    hidden static [string] $Component = 'DiscoveryOptionsParser'
    
    static [bool] TryParseSkipFileAttribute (
        [string] $skipFileAttribute,
        [bool] $ignoreCase,
        [ref] $result
    ) {
        return [System.Enum]::TryParse(
            [SkipFileAttributes],
            $skipFileAttribute,
            $ignoreCase,
            $result
        )
    }
    
    static [bool] TryParseSkipFileAttributes (
        [string[]] $skipFileAttributes,
        [bool] $ignoreCase,
        [ref] $Result,
        [ref] $InvalidValue
    ) {
        [int]$flag = 0
        for ($i = 0; $i -lt $skipFileAttributes.Length; $i ++) {
            [string]$skipFileAttribute = $skipFileAttributes[$i]
            $parsed = $null
            if (-not ([DiscoveryOptionsParser]::TryParseSkipFileAttribute($skipFileAttribute, $ignoreCase, [ref]$parsed))) {
                $InvalidValue.Value = $skipFileAttribute
                return $false
            }
            [int]$flag = $flag -bor ([int] $parsed)
        }
        $Result.Value = $flag
        return $true
    }
    
    static [bool] TryParseNameCaseSensitivity (
        [string] $nameCaseSensitivity,
        [bool] $ignoreCase,
        [ref] $result
    ) {
        return [System.Enum]::TryParse(
            [NameCaseSensitivity],
            $nameCaseSensitivity,
            $ignoreCase,
            $result
        )
    }
    
    static [SkipFileAttributes] ParseSkipFileAttributes (
        [string[]] $skipFileAttributes,
        [System.StringComparison] $comparison
    ) {
        [string]$collectionSemanticName = ([ApplicationParameter]::SkipFileAttributes).ToString()
        if ($null -eq $skipFileAttributes) {
            throw [UseCaseParsingException]::new(
                [DiscoveryOptionsParser]::Component, # ComponentName
                ([ApplicationExceptionContext]::AssertSemanticTokenCollectionPresence).ToString(), # Context
                ([ApplicationExceptionReason]::SemanticTokenCollectionIsNull).ToString(), # Reason
                "$($collectionSemanticName) must not be null." # Message
            )
        }
        if ($skipFileAttributes.Length -eq 0) {
            throw [UseCaseParsingException]::new(
                [DiscoveryOptionsParser]::Component, # ComponentName
                ([ApplicationExceptionContext]::AssertSemanticTokenCollectionMeaningfulness).ToString(), # Context
                ([ApplicationExceptionReason]::SemanticTokenCollectionIsEmpty).ToString(), # Reason
                "$($collectionSemanticName) must not be empty." # Message
            )
        }
        [string]$semanticName = ([ApplicationParameter]::SkipFileAttribute).ToString()
        for ($i = 0; $i -lt $skipFileAttributes.Length; $i ++) {
            [string]$item = $skipFileAttributes[$i]
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
            $skipFileAttribute,
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
        [string] $nameCaseSensitivity,
        [System.StringComparison] $comparison
    ) {
        [string]$semanticName = ([ApplicationParameter]::NameCaseSensitivity).ToString()
        if ([System.String]::IsNullOrWhiteSpace($nameCaseSensitivity)) {
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
            $nameCaseSensitivity,
            $isCaseInsensitive,
            [ref]$parsed
        )
        if (-not $isValid) {
            throw [UseCaseParsingException]::new(
                [DiscoveryOptionsParser]::Component, # ComponentName
                ([ApplicationExceptionContext]::TranslateSemanticTokenToDomainValue).ToString(), # Context
                ([ApplicationExceptionReason]::SemanticTokenTranslationFailure).ToString(), # Reason
                "$($semanticName) is not a valid domain-supported value: '$($nameCaseSensitivity)'." # Message
            )
        }
        return $parsed
    }
    
}