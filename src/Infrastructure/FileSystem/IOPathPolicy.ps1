class IOPathPolicy {
    
    static [IOPathStrategyKind] DecideStrategy (
        [string] $OSKind
    ) {
        switch ($OSKind) {
            'Windows' {
                return [IOPathStrategyKind]::Windows
            }
            'Linux' {
                return [IOPathStrategyKind]::Linux
            }
            'MacOS' {
                return [IOPathStrategyKind]::MacOS
            }
            default {
                return [IOPathStrategyKind]::Unknown
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in DecideStrategy.'
        )
    }
    
}