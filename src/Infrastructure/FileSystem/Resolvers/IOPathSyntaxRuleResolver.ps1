class IOPathSyntaxRuleResolver {
    
    static [bool] ResolveIsTerminalCharAllowed (
        [string] $value,
        [char[]] $invalidValues
    ) {
        [string]$osKind = [RuntimeOSContext]::CurrentPlatform()
        [IOPathStrategyKind]$strategy = [IOPathPolicy]::DecideStrategy($osKind)
        switch ($strategy) {
            Windows {
                return [IOPathSyntaxWindowsRule]::IsTerminalCharValid($value, $invalidValues)
            }
            Linux {
                return [IOPathSyntaxLinuxRule]::IsTerminalCharValid($value, $invalidValues)
            }
            MacOS {
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