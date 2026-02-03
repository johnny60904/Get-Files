class IOPathEvaluationResolver {
    
    static [int] ResolveLengthForSegment (
        [string] $value
    ) {
        [string]$osKind = [RuntimeOSContext]::CurrentPlatform()
        [IOPathStrategyKind]$strategy = [IOPathPolicy]::DecideStrategy($osKind)
        switch ($strategy) {
            Windows {
                return [IOPathSegmentLengthWindowsEvaluator]::Evaluate($value)
            }
            Linux {
                return [IOPathSegmentLengthLinuxEvaluator]::Evaluate($value)
            }
            MacOS {
                return [IOPathSegmentLengthMacOSEvaluator]::Evaluate($value)
            }
            # Unknown
            default {
                throw [System.PlatformNotSupportedException]::new('Unsupported os in ResolveLengthForSegment.')
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in ResolveLengthForSegment.'
        )
    }
    
}