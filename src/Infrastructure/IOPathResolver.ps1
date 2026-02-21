class IOPathResolver {
    
    static [string] ResolvePath (
        [string] $path
    ) {
        [string]$resolved = [StringTokenResolver]::ResolveEndsWithExactCandidate(
            $path,
            [string[]]([PathSeparatorTokens]::Tokens),
            [StringComparisonDefault]::Default
        )
        if ($resolved) { # e.g. 'C:/demo\test\' / 'D/:demo\test/' -> '\' or '/'
            return [System.IO.Path]::GetFullPath(
                [StringPrunator]::RemoveCandidateAndTrim($path, $resolved)
            )
        } else {
            return [System.IO.Path]::GetFullPath($path)
        }
        
    }
    
    static [string] ResolveChildDirectoryPath (
        [string] $parentDirectory,
        [string] $childName
    ) {
        [string]$combined = [System.IO.Path]::Join($parentDirectory, $childName)
        return [System.IO.Path]::GetFullPath($combined)
    }
    
    static [string[]] ResolveChildPathsBatch (
        [string] $parentDirectory,
        [string[]] $childNames
    ) {
        [string]$resolvedParentDir = [System.IO.Path]::GetFullPath($parentDirectory)
        if ($childNames.Length -eq 0) { return @($resolvedParentDir) }
        $result = [System.Collections.Generic.List[string]]::new()
        for ($i = 0; $i -lt $childNames.Length; $i ++) {
            [string]$combined = [System.IO.Path]::Join($resolvedParentDir, $childNames[$i])
            [string]$resolved = [System.IO.Path]::GetFullPath($combined)
            $result.Add($resolved)
        }
        return $result.ToArray()
    }
    
}