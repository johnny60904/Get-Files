class IOPathSyntaxRuleResolver {
    
    static [bool] ResolveIsTerminalCharAllowed (
        [string] $value,
        [char[]] $invalidValues
    ) {
        [string]$osKind = [RuntimeOSContext]::CurrentPlatform()
        [IOPathStrategyKind]$strategy = [IOPathPolicy]::DecideStrategy($osKind)
        switch ($strategy) {
            ([IOPathStrategyKind]::Windows) {
                return [IOPathSyntaxWindowsRule]::IsTerminalCharValid($value, $invalidValues)
            }
            ([IOPathStrategyKind]::Linux) {
                return [IOPathSyntaxLinuxRule]::IsTerminalCharValid($value, $invalidValues)
            }
            ([IOPathStrategyKind]::MacOS) {
                return [IOPathSyntaxMacOSRule]::IsTerminalCharValid($value, $invalidValues)
            }
            # Unknown
            default {
                throw [System.PlatformNotSupportedException]::new('Unsupported os in ResolveIsTerminalCharAllowed.')
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in ResolveIsTerminalCharAllowed.'
        )
    }
    
}