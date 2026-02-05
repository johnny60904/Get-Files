
class FilesAdvancedOptions {
    
    [bool] $ContinueOnAccessDenied
    [int] $IOBufferSize
    [string[]] $ExcludedFileAttributes
    [string] $MatchCaseSensitivity
    
    FilesAdvancedOptions (
        [bool] $continueOnAccessDenied,
        [int] $ioBufferSize,
        [string[]] $excludedFileAttributes,
        [string] $matchCaseSensitivity
    ) {
        $this.ContinueOnAccessDenied = $continueOnAccessDenied
        $this.IOBufferSize = $ioBufferSize
        $this.ExcludedFileAttributes = $excludedFileAttributes
        $this.MatchCaseSensitivity = $matchCaseSensitivity
    }
    
}