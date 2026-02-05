class SwitchSelector {
    
    static [string] Select (
        [switch] $condition,
        [string] $whenPresent,
        [string] $whenUnpresent
    ) {
        if ($condition.IsPresent) {
            return $whenPresent
        } elseif (-not ($condition.IsPresent)) {
            return $whenUnpresent
        } else {
            # Unreachable
            throw [System.InvalidOperationException]::new(
                'Unreachable code path in Select.'
            )
        }
    }
    
}