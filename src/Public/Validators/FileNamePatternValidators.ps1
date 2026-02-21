class FileNamePatternValidators {
    
    # 必須是 file name semantic, instead of path semantic (/ or \)
    static [void] ValidateTokenSemantic (
        [string] $value,
        [string] $paramName
    ) {
        [string]$invalid = [FileNamePatternResolver]::ResolveFirstContainedDirectorySeparator($value)
        if ($invalid) {
            throw [System.ArgumentException]::new(
                "Invalid character in '$($paramName)' ($($value)): '$($invalid)'.   value must be a file name pattern.",
                $paramName
            )
        }
    }
    
    # 確保不是 Rooted path
    static [void] ValidateStructureValid (
        [string] $value,
        [string] $paramName
    ) {
        if ([FileNamePatternPredicate]::IsRootedPathStructureContained($value)) {
            throw [System.ArgumentException]::new(
                "Invalid structure in '$($paramName)': $($value).   value must be a file name pattern.",
                $paramName
            )
        }
    }
    
    # 不能是 . 或 ..
    static [void] ValidateToken (
        [string] $value,
        [string] $paramName
    ) {
        if ([FileNamePatternPredicate]::IsEqualToDotDirectory($value)) {
            throw [System.ArgumentException]::new(
                "'$($paramName)' invalid: $($value).   value must be a file name pattern.",
                $paramName
            )
        }
    }
    
    # 不能是相對路徑語意, 如 ./foo.text 或 ../*.ps1
    static [void] ValidateInitialValid (
        [string] $value,
        [string] $paramName
    ) {
        [string]$invalid = [FileNamePatternResolver]::ResolveFirstContainedDotDirectory($value)
        if ($invalid) {
            throw [System.ArgumentException]::new(
                "Invalid structure in '$($paramName)' ($($value)): '$($invalid)'.   value must be a file name pattern.",
                $paramName
            )
        }
    }
    
    # 不能是 ASCII control characters
    static [void] ValidateCharactersIntrinsic (
        [string] $value,
        [string] $paramName
    ) {
        [string]$invalid = [FileNamePatternResolver]::ResolveFirstContainedControlChar($value)
        if ($invalid) {
            throw [System.ArgumentException]::new(
                "Invalid character in '$($paramName)' ($($value)): '$($invalid)'.   value must be a file name pattern.",
                $paramName
            )
        }
    }
    
    static [void] ValidateFileNamePatternSyntax (
        [string] $value,
        [string] $paramName
    ) {
        [FileNamePatternValidators]::ValidateTokenSemantic($value, $paramName)
        [FileNamePatternValidators]::ValidateStructureValid($value, $paramName)
        [FileNamePatternValidators]::ValidateToken($value, $paramName)
        [FileNamePatternValidators]::ValidateInitialValid($value, $paramName)
        [FileNamePatternValidators]::ValidateCharactersIntrinsic($value, $paramName)
    }
    
    static [void] ValidateFileNamePattern (
        [string] $value,
        [string] $paramName
    ) {
        [StringValidators]::ValidateIsRequired($value, $paramName)
        # 只處理檔名語意，不處理路徑
        [string]$fileName = [FileNamePatternTransformer]::ExtractFileName($value)
        if ([FileNamePatternClassifier]::IsUniversalWildcard($fileName)) { return } # * / *.*
        # *.abc.test.txt / demo.test.* / abc.demo.txt / *.ps1 / readme.* / .etc
        [FileNamePatternValidators]::ValidateFileNamePatternSyntax($fileName, $paramName)
    }
    
}