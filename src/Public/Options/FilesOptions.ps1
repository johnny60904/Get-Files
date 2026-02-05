
class FilesOptions {
    
    [bool] $IgnoreErrors
    [int] $BufferSizeKB
    [string[]] $ExcludeAttributes
    [string] $CaseSensitivity
    
    FilesOptions (
        [bool] $ignoreErrors,
        [int] $bufferSizeKB,
        [string[]] $excludeAttributes,
        [string] $caseSensitivity
    ) {
        $this.IgnoreErrors = $ignoreErrors
        $this.BufferSizeKB = $bufferSizeKB
        $this.ExcludeAttributes = $excludeAttributes
        $this.CaseSensitivity = $caseSensitivity
    }
    
}