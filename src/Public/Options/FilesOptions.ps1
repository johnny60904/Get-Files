
class FilesOptions {
    
    [bool] $IgnoreErrors
    [string] $CaseSensitivity
    
    FilesOptions (
        [bool] $ignoreErrors,
        [string] $caseSensitivity
    ) {
        $this.IgnoreErrors = $ignoreErrors
        $this.CaseSensitivity = $caseSensitivity
    }
    
}