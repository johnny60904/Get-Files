class IOPathStructureRuleResolver {
    
    # 檔案系統 structure (絕對路徑) 規則 (not URI 網路路徑):
    # Windows 必須包含 Root -> IsPathFullyQualified
    # Linux/macOS 以 / 開頭 = 絕對 -> StartsWith('/')
    # (Windows) Absolute Path -> 結果為 True 為過關; Relative Path -> 結果為 False 為過關
    
    static [bool] ResolveIsValidAbsolutePath (
        [string] $path
    ) {
        [string]$osKind = [RuntimeOSContext]::CurrentPlatform()
        [IOPathStrategyKind]$strategy = [IOPathPolicy]::DecideStrategy($osKind)
        switch ($strategy) {
            Windows {
                return [IOPathStructureWindowsRule]::IsQualifiedAbsolute($path)
            }
            Linux {
                return [IOPathStructureLinuxRule]::IsQualifiedAbsolute($path)
            }
            MacOS {
                return [IOPathStructureMacOSRule]::IsQualifiedAbsolute($path)
            }
            # Unknown
            default {
                throw [System.PlatformNotSupportedException]::new('Unsupported os in ResolveIsValidAbsolutePath.')
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in ResolveIsValidAbsolutePath.'
        )
    }
    
}