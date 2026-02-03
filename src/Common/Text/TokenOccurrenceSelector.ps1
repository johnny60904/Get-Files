class TokenOccurrenceSelector {
    
    static [string] SelectEarlierOccurringToken (
        [string] $tokenA,
        [string] $tokenB,
        [string] $text
    ) {
        [int]$idxA = $text.IndexOf($tokenA)
        [int]$idxB = $text.IndexOf($tokenB)
        [string]$result = if ($idxA -lt $idxB) {
            $tokenA
        } else {
            $tokenB
        }
        return $result
    }
    
}