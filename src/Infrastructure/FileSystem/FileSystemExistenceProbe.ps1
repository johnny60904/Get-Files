class FileSystemExistenceProbe {
    
    static [bool] IsExistedFile (
        [string] $filePath
    ) {
        return [System.IO.File]::Exists($filePath)
    }
    
    static [bool] IsExistedDirectory (
        [string] $directory
    ) {
        return [System.IO.Directory]::Exists($directory)
    }
    
}