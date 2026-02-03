class IOPathViolationSelector {
    
    static [string] SelectEarlierInvalidToken (
        [string] $invalidTokenA,
        [string] $invalidTokenB,
        [string] $value
    ) {
        return [TokenOccurrenceSelector]::SelectEarlierOccurringToken(
            $invalidTokenA,
            $invalidTokenB,
            $value
        )
    }
    
}