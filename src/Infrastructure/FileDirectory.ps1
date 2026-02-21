class FileDirectory {
    
    static [string] GetName (
        [string] $path
    ) {
        return [System.IO.Path]::GetDirectoryName($path)
    }
    
}