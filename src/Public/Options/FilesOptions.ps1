
class FilesOptions {
    
    [bool] $ContinueOnAccessDenied
    [int] $IOBufferSize
    [string[]] $ExcludedFileAttributes
    [string] $MatchCaseSensitivity
    
    FilesOptions (
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