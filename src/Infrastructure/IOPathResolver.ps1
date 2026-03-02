class IOPathResolver {
    
    [string] $Path
    
    IOPathResolver (
        [string] $path
    ) {
        $this.Path = $path
    }
    
    hidden static [string] ResolvePath (
        [string] $path
    ) {
        [string]$resolved = [StringTokenResolver]::ResolveEndsWithExactCandidate(
            $path,
            [string[]]([PathSeparatorTokens]::Tokens)
        )
        if ($resolved) { # e.g. 'C:/demo\test\' / 'D/:demo\test/' -> '\' or '/'
            [int]$resolvedIndex = [StringMeasurer]::GetIndexOfTheEnd($path)
            return [System.IO.Path]::GetFullPath(
                [StringPrunator]::RemoveTerminalAndTrimByIndex($path, $resolvedIndex)
            )
        } else {
            return [System.IO.Path]::GetFullPath($path)
        }
    }
    
    [string] Resolve () {
        return [IOPathResolver]::ResolvePath($this.Path)
    }
    
}