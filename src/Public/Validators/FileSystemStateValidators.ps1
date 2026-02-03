class FileSystemStateValidators {
    
    static [void] ValidateFileExistence (
        [string] $filePath,
        [string] $paramName
    ) {
        [bool]$isExisted = [FileSystemExistenceProbe]::IsExistedFile($filePath)
        if (-not $isExisted) {
            throw [System.ArgumentException]::new(
                "File does not exist.   File Path: '$($filePath)'.   Please check and try again.",
                $paramName
            )
        }
    }
    
    static [void] ValidateDirectoryExistence (
        [string] $directory,
        [string] $paramName
    ) {
        [bool]$isExisted = [FileSystemExistenceProbe]::IsExistedDirectory($directory)
        if (-not $isExisted) {
            throw [System.ArgumentException]::new(
                "Directory does not exist.   Directory: '$($directory)'.   Please check and try again.",
                $paramName
            )
        }
    }
    
}