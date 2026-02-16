class IOPathEnumeration  {
    
    static [System.Collections.Generic.IEnumerable[string]] EnumerateFiles (
        [string] $directory,
        [string] $fileFilter,
        [System.IO.EnumerationOptions] $enumOpts
    ) {
        return [System.IO.Directory]::EnumerateFiles($directory, $fileFilter, $enumOpts)
    }
    
    static [System.Collections.Generic.IEnumerable[string]] EnumerateDirectories (
        [string] $directory,
        [string] $directoryFilter,
        [System.IO.EnumerationOptions] $enumOpts
    ) {
        return [System.IO.Directory]::EnumerateDirectories($directory, $directoryFilter, $enumOpts)
    }
    
}