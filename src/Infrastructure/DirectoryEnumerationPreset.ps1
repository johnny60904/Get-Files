# Predefined EnumerationOptions defaults / preset
# 固定住, 不給外部作參數使用, 反正其它參數設定已足夠外部應付大部分使用了
# 因為固定住的值, 跟直接 [System.IO.EnumerationOptions]::new() 的預設值一樣:
# -> RecurseSubdirectories = $false
# -> MatchType::Simple
# -> MaxRecursionDepth = 2,147,483,647 (MaxValue)
# -> ReturnSpecialDirectories = $false
# 因此 class 命名 role semantic keyword 可以是 *Defaults

# 微調但仍屬「推薦設定 (Default)」=> *Preset
# 對應特定情境 => *Profile
# 帶有安全 / 行為限制 => Policy
# 完全 Domain 私有 => InternalConfig / InternalOptions
class DirectoryEnumerationPreset { # or DirectoryEnumerationDefaults
    
    # RecurseSubdirectories
    # 開啟 true 會和實作 (DFS / BFS) 不一致, 結果 / 行為 會偏移
    hidden static [bool] $IncludeSubdirectories = $false
    
    # MatchType
    # Simple -> cross platform 一致, 可預期
    # 不打算使用 Win32 (只針對 Windows, 尤其老舊系統)
    hidden static [System.IO.MatchType] $PatternMatchStrategy = [System.IO.MatchType]::Simple
    
    # MaxRecursionDepth
    # RecurseSubdirectories 為 False, 為對應語意一致, 此處應為 0
    hidden static [int] $MaxRecursionDepth = 0
    
    # ReturnSpecialDirectories
    # 不打算 return . / ..  , 用不上
    hidden static [bool] $IncludeDotDirectories = $false
    
}