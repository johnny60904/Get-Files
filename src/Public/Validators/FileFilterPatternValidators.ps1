class FileFilterPatternValidators {
    
    static [void] ValidateFileFilterPattern (
        [string] $value,
        [string] $paramName
    ) {
        [StringValidators]::ValidateNotNullOrWhiteSpace($value, $paramName)
        if ([ExclusiveFileFilterPatternPredicate]::IsExclusiveFileFilterPattern($value)) { return }
        # 只處理檔名語意，不處理路徑
        [string]$fileName = [FileFilterExtractor]::ExtractFileName($value)
        [IOPathSegmentValidators]::ValidateSyntax($fileName, 'FileFilter', $paramName)
        # 必須包含一個 dot (abc.test.txt)
        # xxx. 結尾非法的驗證檢查,
        # ValidateSyntax 裡的 ValidateTerminalCharAllowed 就會驗證檢查了 (針對 Windows),
        # 故此處只有驗證檢查剩餘部分
        [int]$dotIdx = $fileName.IndexOfAny('.')
        if ($dotIdx -eq -1) {
            throw [System.ArgumentException]::new(
                "INVALID file filter '$($value)'.   Missing file extension.",
                $paramName
            )
        }
        if ($dotIdx -eq 0) { # .xxx
            throw [System.ArgumentException]::new(
                "INVALID file filter '$($value)'.   Missing file name.",
                $paramName
            )
        }
    }
    
}