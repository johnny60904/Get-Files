class FilePath {
    
    static [string] GetName (
        [string] $path
    ) {
        return [System.IO.Path]::GetFileName($path)
    }
    
}