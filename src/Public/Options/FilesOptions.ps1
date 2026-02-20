
class FilesOptions {
    
    [bool] $IgnoreErrors
    [string] $CaseSensitivity
    [string] $RecurseMode
    
    FilesOptions (
        [bool] $ignoreErrors,
        [string] $caseSensitivity,
        [string] $recurseMode
    ) {
        $this.IgnoreErrors = $ignoreErrors
        $this.CaseSensitivity = $caseSensitivity
        $this.RecurseMode = $recurseMode
    }
    
}