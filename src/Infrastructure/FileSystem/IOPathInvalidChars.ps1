class IOPathInvalidChars {
    
    static [char[]] Get () {
        return [System.IO.Path]::GetInvalidPathChars()
    }
    
}