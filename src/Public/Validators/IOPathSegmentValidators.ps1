# PathSegment (a name token): FileName (extension included) / FolderName / FileFilter
class IOPathSegmentValidators {
    
    # 使用 System.IO.Path.GetInvalidPathChars 初篩 -> 廣義, 快速, 非完整語意, 非本系統定義規則
    # => 這個 value 明顯不可能成為 PathSegment
    static [void] ValidateCharactersIntrinsic (
        [string] $value, # FileName (include extension) / FolderName / FileFIlter
        [string] $displayName, # role
        [string] $paramName
    ) {
        [char[]]$invalidChars = [IOPathInvalidChars]::Get()
        [int]$invalidCharIdx = $value.IndexOfAny($invalidChars)
        if ($invalidCharIdx -ge 0) {
            [string]$invalidCharDiagnostic = [ArgumentErrorDiagnosticFactory]::FormatCharHexDiagnostic(
                $value[$invalidCharIdx],
                "X4",
                "{0} (Hex: {1})"
            )
            [string]$invalidCharsDiagnostic = [ArgumentErrorDiagnosticFactory]::FormatInvalidCharsDiagnostic(
                $invalidChars,
                "[ Value: '{0}', Hex Value: {1:X4} ]",
                ', ',
                "INVALID characters: {0}"
            )
            throw [System.ArgumentException]::new(
                "INVALID character(s) in $($displayName) (First Found): '$($invalidCharDiagnostic)'.   $($invalidCharsDiagnostic).   $($displayName) Value: '$($value)'.",
                $paramName
            )
        }
    }
    
    # 使用本系統的完整規則驗證 (OS-Specific Rule)
    # ReservedTokens / SemanticReservedNames / FinderInvalidTokens
    # => 在此系統定義的檔案系統語意下, 這是否是一個合法的 Path Segment
    static [void] ValidateTokensPlatformSemantic (
        [string] $value,
        [string] $displayName,
        [string] $paramName
    ) {
        [string]$invalidToken = [IOPathViolationResolver]::ResolveFirstContainedInvalidToken($value)
        if (($invalidToken.Length) -gt 0) {
            throw [System.ArgumentException]::new(
                "INVALID token(s)(os-specific reserved / semantic reserved chars / names) in $($displayName) (First Found): '$($invalidToken)'.   $($displayName) Value: '$($value)'.",
                $paramName
            )
        }
    }
    
    # 主要針對 Windows reserved DOS names
    # 使用本系統的完整規則驗證 (OS-Specific Rule)
    # ReservedTokens / SemanticReservedNames / FinderInvalidTokens
    # => 在此系統定義的檔案系統語意下, 這是否是一個合法的 Path Segment
    static [void] ValidateExclusiveTokensPlatformSemantic (
        [string] $value,
        [string] $displayName,
        [string] $paramName
    ) {
        [string]$exclusiveInvalidToken = [IOPathSegmentViolationResolver]::ResolveExactExclusiveInvalidToken($value)
        if (($exclusiveInvalidToken.Length) -gt 0) {
            throw [System.ArgumentException]::new(
                "INVALID exclusive token (os-specific semantic reserved names) exactly matched: '$($exclusiveInvalidToken)'.   $($displayName) Value: '$($value)'.",
                $paramName
            )
        }
    }
    
    # 主要針對 Windows, Linux / MacOS 結尾 '.' 或 ' ' 均合法, 或是 MacOS 的 Finder 會自動處理
    static [void] ValidateTerminalCharAllowed (
        [string] $value,
        [string] $displayName,
        [string] $paramName
    ) {
        [bool]$isValid = [IOPathSyntaxRuleResolver]::ResolveIsTerminalCharAllowed($value, [char[]]@('.', ' '))
        if (-not $isValid) {
            throw [System.ArgumentException]::new(
                "$($displayName) cannot end with '.' or ' ' (whitespace).   $($displayName) Value: '$($value)'.",
                $paramName
            )
        }
    }
    
    static [void] ValidateLength (
        [string] $value,
        [string] $displayName,
        [string] $paramName
    ) {
        [int]$evaluatedLength = [IOPathEvaluationResolver]::ResolveLengthForSegment($value)
        [int]$maxLengthLimit = [IOPathConstraintsResolver]::ResolveMaxLengthLimitForSegment()
       if ($evaluatedLength -gt $maxLengthLimit) { 
            [string]$maxLimitDiagnostic = [ArgumentErrorDiagnosticFactory]::FormatMaxLimitDiagnostic(
                $maxLengthLimit,
                "{0} {1} bytes / characters (UTF-8 bytes / UTF-16 code units)"
            )
            throw [System.ArgumentOutOfRangeException]::new(
                $paramName,
                $value,
                "$($displayName) length exceeded the maximum allowed ($($maxLimitDiagnostic)).   $($displayName) Length: $($evaluatedLength)."
            )
       }
    }
    
    static [void] ValidateSyntax (
        [string] $value,
        [string] $displayName,
        [string] $paramName
    ) {
        [StringValidators]::ValidateNotNullOrWhiteSpace($value, $paramName)
        [IOPathSegmentValidators]::ValidateCharactersIntrinsic($value, $displayName, $paramName)
        [IOPathSegmentValidators]::ValidateTokensPlatformSemantic($value, $displayName, $paramName)
        [IOPathSegmentValidators]::ValidateExclusiveTokensPlatformSemantic($value, $displayName, $paramName)
        [IOPathSegmentValidators]::ValidateTerminalCharAllowed($value, $displayName, $paramName)
        [IOPathSegmentValidators]::ValidateLength($value, $displayName, $paramName)
    }
    
    # include extension
    static [void] ValidateFileNameSyntax (
        [string] $fileName,
        [string] $paramName
    ) {
        [IOPathSegmentValidators]::ValidateSyntax($fileName, 'FileName', $paramName)
    }
    
    static [void] ValidateFolderNameSyntax (
        [string] $folderName,
        [string] $paramName
    ) {
        [IOPathSegmentValidators]::ValidateSyntax($folderName, 'FolderName', $paramName)
    }
    
    static [bool] ValidateIsNullOrEmpty (
        [string] $value
    ) {
        return [System.String]::IsNullOrEmpty($value)
    }
    
}