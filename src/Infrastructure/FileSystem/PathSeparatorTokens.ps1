class PathSeparatorTokens {
    
    hidden static [char] $DirectorySeparator = [System.IO.Path]::DirectorySeparatorChar
    
    hidden static [char] $AltDirectorySeparator = [System.IO.Path]::AltDirectorySeparatorChar
    
    hidden static [char[]] $Tokens = @(
        [System.IO.Path]::AltDirectorySeparatorChar,
        [System.IO.Path]::DirectorySeparatorChar
    )
    
}