class StringPrunator {
    
    static [string] RemoveFirstOccurrenceAndTrim (
        [string] $value,
        [string] $candidate
    ) {
        [int]$idx = $value.IndexOf($candidate)
        return $value.Remove($idx).Trim()
    }
    
    static [string] RemoveTerminalAndTrimByIndex (
        [string] $value,
        [int] $index
    ) {
        return $value.Remove($index).Trim()
    }
    
}