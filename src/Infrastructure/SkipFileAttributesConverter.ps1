class SkipFileAttributesConverter  {
    
    static [System.IO.FileAttributes] ToFileAttributes (
        [SkipFileAttributes] $skipAttrs
    ) {
        [int]$skipAttrsFlags = [System.Convert]::ToInt32($skipAttrs)
        return ([System.IO.FileAttributes]$skipAttrsFlags)
    }
    
}