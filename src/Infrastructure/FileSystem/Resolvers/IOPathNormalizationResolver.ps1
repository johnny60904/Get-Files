class IOPathNormalizationResolver {
    
    static [string] ResolveForSegment (
        [string] $value
    ) {
        [string]$osKind = [RuntimeOSContext]::CurrentPlatform()
        [IOPathStrategyKind]$strategy = [IOPathPolicy]::DecideStrategy($osKind)
        switch ($strategy) {
            Windows {
                return [IOPathSegmentWindowsNormalizer]::Normalize($value)
            }
            Linux {
                return [IOPathSegmentLinuxNormalizer]::Normalize($value)
            }
            MacOS {
                return [IOPathSegmentMacOSNormalizer]::Normalize($value)
            }
            # Unknown
            default {
                throw [System.PlatformNotSupportedException]::new('Unsupported os in ResolveForSegment.')
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in ResolveForSegment.'
        )
    }
    
}