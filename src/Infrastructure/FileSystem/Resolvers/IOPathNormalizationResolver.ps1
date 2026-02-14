class IOPathNormalizationResolver {
    
    static [string] ResolveForSegment (
        [string] $value
    ) {
        [string]$osKind = [RuntimeOSContext]::CurrentPlatform()
        [IOPathStrategyKind]$strategy = [IOPathPolicy]::DecideStrategy($osKind)
        switch ($strategy) {
            ([IOPathStrategyKind]::Windows) {
                return [IOPathSegmentWindowsNormalizer]::Normalize($value)
            }
            ([IOPathStrategyKind]::Linux) {
                return [IOPathSegmentLinuxNormalizer]::Normalize($value)
            }
            ([IOPathStrategyKind]::MacOS) {
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