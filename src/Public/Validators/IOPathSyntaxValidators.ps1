class IOPathSyntaxValidators {
    
    # Path -> OS defined -> 驗證本就較寬鬆, 是 OS 責任, 也必須如此
    # 使用 System.IO.Path.GetInvalidPathChars 初篩 -> 廣義, 快速, 非完整語意, 非本系統定義規則
    # => 這個 value 明顯不可能成為 Path
    static [void] ValidateCharactersIntrinsic (
        [string] $path,
        [string] $paramName
    ) {
        [char[]]$invalidChars = [IOPathInvalidChars]::Get()
        [int]$invalidCharIdx = $path.IndexOfAny($invalidChars)
        if ($invalidCharIdx -ge 0) {
            [string]$invalidCharDiagnostic = [ArgumentErrorDiagnosticFactory]::FormatCharHexDiagnostic(
                $path[$invalidCharIdx],
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
                "INVALID character(s) in path (First Found): '$($invalidCharDiagnostic)'.   $($invalidCharsDiagnostic).   Path Value: '$($path)'.",
                $paramName
            )
        }
    }
    
    static [void] ValidateLength (
        [string] $path,
        [string] $paramName
    ) {
        [int]$length = $path.Length
        [int]$maxLengthLimit = [IOPathMaxLengthResolver]::ResolveEffectiveMaxLength()
        if ($length -gt $maxLengthLimit) {
            [string]$maxLimitDiagnostic = [ArgumentErrorDiagnosticFactory]::FormatMaxLimitDiagnostic(
                $maxLengthLimit,
                "{0} {1} bytes / characters (UTF-8 bytes / UTF-16 code units)"
            )
            throw [System.ArgumentOutOfRangeException]::new(
                $paramName,
                $path,
                "Path length exceeded the maximum allowed ($($maxLimitDiagnostic)).   Path Length: $($length)."
            )
        }
    }
    
    static [void] ValidateRelativePathStructure (
        [string] $path,
        [string] $paramName
    ) {
        [bool]$isValid = (-not ([IOPathStructureRuleResolver]::ResolveIsValidAbsolutePath($path))) # False
        if (-not $isValid) { # True
            throw [System.ArgumentException]::new(
                "Path structure UNQUALIFIED: '$($path)'.   Path must be an RELATIVE path.",
                $paramName
            )
        }
    }
    
    static [void] ValidateAbsolutePathStructure (
        [string] $path,
        [string] $paramName
    ) {
        [bool]$isValid = [IOPathStructureRuleResolver]::ResolveIsValidAbsolutePath($path)
        if (-not $isValid) {
            throw [System.ArgumentException]::new(
                "Path structure UNQUALIFIED: '$($path)'.   Path must be an ABSOLUTE path.",
                $paramName
            )
        }
    }
    
    static [void] ValidateSyntax (
        [string] $path,
        [string] $paramName
    ) {
        [StringValidators]::ValidateNotNullOrWhiteSpace($path, $paramName)
        [IOPathSyntaxValidators]::ValidateCharactersIntrinsic($path, $paramName)
        [IOPathSyntaxValidators]::ValidateLength($path, $paramName)
    }
    
    static [void] ValidateRelativePathSyntax (
        [string] $path,
        [string] $paramName
    ) {
        [IOPathSyntaxValidators]::ValidateSyntax($path, $paramName)
        [IOPathSyntaxValidators]::ValidateRelativePathStructure($path, $paramName)
    }
    
    static [void] ValidateAbsolutePathSyntax (
        [string] $path,
        [string] $paramName
    ) {
        [IOPathSyntaxValidators]::ValidateSyntax($path, $paramName)
        [IOPathSyntaxValidators]::ValidateAbsolutePathStructure($path, $paramName)
    }
    
}