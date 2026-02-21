class StringComposer {
    
    static [string] CombineAndTrim (
        [string] $valueLeft,
        [string] $valueRight
    ) {
        return ($valueLeft + $valueRight).Trim()
    }
    
}