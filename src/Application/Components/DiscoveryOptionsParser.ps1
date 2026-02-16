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
        [ApplicationParameter]$semanticCollectionIdentity = [ApplicationParameter]::SkipFileAttributes
        [string]$semanticCollectionName = $semanticCollectionIdentity.ToString()
        if ($null -eq $skipFileAttributes) {
            throw [UseCaseParsingException]::new(
                [DiscoveryOptionsParser]::Component, # ComponentName
                [ApplicationExceptionContext]::AssertSemanticTokenCollectionPresence, # Context
                [ApplicationExceptionReason]::CollectionIsNull, # Reason
                $semanticCollectionIdentity, # FieldName
                $skipFileAttributes, # TargetObject
                "$($semanticCollectionName) must not be null." # Message
            )
        }
        if ($skipFileAttributes.Length -eq 0) {
            throw [UseCaseParsingException]::new(
                [DiscoveryOptionsParser]::Component, # ComponentName
                [ApplicationExceptionContext]::AssertSemanticTokenCollectionMeaningfulness, # Context
                [ApplicationExceptionReason]::CollectionIsEmpty, # Reason
                $semanticCollectionIdentity, # FieldName
                $skipFileAttributes, # TargetObject
                "$($semanticCollectionName) must not be empty." # Message
            )
        }
        [ApplicationParameter]$semanticIdentity = [ApplicationParameter]::SkipFileAttribute
        [string]$semanticName = $semanticIdentity.ToString()
        for ($i = 0; $i -lt $skipFileAttributes.Length; $i ++) {
            [string]$skipFileAttribute = $skipFileAttributes[$i]
            if ([System.String]::IsNullOrWhiteSpace($skipFileAttribute)) {
                throw [UseCaseParsingException]::new(
                    [DiscoveryOptionsParser]::Component, # ComponentName
                    [ApplicationExceptionContext]::AssertSemanticTokenMeaningfulness, # Context
                    [ApplicationExceptionReason]::NullOrWhiteSpace, # Reason
                    $semanticIdentity, # FieldName
                    $skipFileAttribute, # TargetObject
                    "$($semanticName) must not be null, empty, or whitespace." # Message
                )
            }
        }
        [bool]$isCaseInsensitive = [StringComparisonInspector]::IsCaseInsensitive($comparison)
        $parsed = $null
        $invalid = $null
        [bool]$isValid = [DiscoveryOptionsParser]::TryParseSkipFileAttributes(
            $skipFileAttributes,
            $isCaseInsensitive,
            [ref]$parsed,
            [ref]$invalid
        )
        if (-not $isValid) {
            throw [UseCaseParsingException]::new(
                [DiscoveryOptionsParser]::Component, # ComponentName
                [ApplicationExceptionContext]::TranslateSemanticTokenToDomainValue, # Context
                [ApplicationExceptionReason]::TranslationFailure, # Reason
                $semanticIdentity, # FieldName
                $invalid, # TargetObject
                "$($semanticName) is not a valid domain-supported value: '$($invalid)'." # Message
            )
        }
        return $parsed
    }
    
    static [NameCaseSensitivity] ParseNameCaseSensitivity (
        [string] $nameCaseSensitivity,
        [System.StringComparison] $comparison
    ) {
        [ApplicationParameter]$semanticIdentity = [ApplicationParameter]::NameCaseSensitivity
        [string]$semanticName = $semanticIdentity.ToString()
        if ([System.String]::IsNullOrWhiteSpace($nameCaseSensitivity)) {
            throw [UseCaseParsingException]::new(
                [DiscoveryOptionsParser]::Component, # ComponentName
                [ApplicationExceptionContext]::AssertSemanticTokenMeaningfulness, # Context
                [ApplicationExceptionReason]::NullOrWhiteSpace, # Reason
                $semanticIdentity, # FieldName
                $nameCaseSensitivity, # TargetObject
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
                [ApplicationExceptionContext]::TranslateSemanticTokenToDomainValue, # Context
                [ApplicationExceptionReason]::TranslationFailure, # Reason
                $semanticIdentity, # FieldName
                $nameCaseSensitivity, # TargetObject
                "$($semanticName) is not a valid domain-supported value: '$($nameCaseSensitivity)'." # Message
            )
        }
        return $parsed
    }
    
}