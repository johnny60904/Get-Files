class IOPathExtractor {
    
    static [string] ExtractFolderName (
        [string] $path
    ) {
        # Notice: [System.IO.Path]::GetFileName("C:\") -> ""
        # 但若是如此的話, 以下設計處理剛好可以得到要的結果
        if ([CharPatternDetector]::EndsWithAny($path, [char[]]@('/', '\'))) {
            return [System.IO.Path]::GetFileName($path.Remove($path.Length - 1))
        } else {
            return [System.IO.Path]::GetFileName($path)
        }
    }
    
}