class BooleanSelector {
    
    static [string] Select (
        [bool] $condition,
        [string] $whenTrue,
        [string] $whenFalse
    ) {
        if ($condition) {
            return $whenTrue
        } elseif (-not $condition) {
            return $whenFalse
        } else {
            # Unreachable
            throw [System.InvalidOperationException]::new(
                'Unreachable code path in Select.'
            )
        }
    }
    
}