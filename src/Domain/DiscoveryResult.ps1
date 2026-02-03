# Result 的責任只有一個：
# 「我保證這是一個完成、穩定、已排序（或已定義順序）的結果」
class DiscoveryResult {
    
    [string[]] $DiscoveredFiles
    
    DiscoveryResult ([string[]] $discoveredFiles) {
        $this.DiscoveredFiles = $discoveredFiles
    }
    
}