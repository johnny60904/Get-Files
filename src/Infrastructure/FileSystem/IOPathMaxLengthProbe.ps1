class IOPathMaxLengthProbe {
    
    # 二分法
    static [int] ProbeEffectiveMaxLength (
        [int] $theoreticalMaxLimit
    ) {
        [string]$basePath = [System.IO.Path]::GetPathRoot([System.Environment]::CurrentDirectory) # 跨平台
        [int]$min = 1
        [int]$max = $theoreticalMaxLimit
        [int]$result = 0
        while ($min -le $max) {
            [int]$mid = [System.Math]::Floor(($min + $max) / 2)
            [string]$testPath = $basePath + ('a' * ($mid - $basePath.Length))
            try {
                [string]$full = [System.IO.Path]::GetFullPath($testPath) # 若超過最大長度上限, 就原生拋錯了
                [int]$result = $mid
                [int]$min = $mid + 1
            } catch {
                $max = $mid - 1
            }
        }
        return $result
    }
    
}