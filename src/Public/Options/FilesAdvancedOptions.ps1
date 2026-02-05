
class FilesAdvancedOptions {
    
    [int] $BufferSizeKB
    [string[]] $ExcludeAttributes
    
    FilesAdvancedOptions (
        [int] $bufferSizeKB,
        [string[]] $excludeAttributes
    ) {
        $this.BufferSizeKB = $bufferSizeKB
        $this.ExcludeAttributes = $excludeAttributes
    }
    
}