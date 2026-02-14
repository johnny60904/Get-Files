class IOPathConstraintsResolver {
    
    # Windows NTFS ≠ case-insensitive filesystem
    # Linux ext4 ≠ always case-sensitive
    # macOS APFS configurable
    # OS 規則預設不區分大小寫
    
    static [string[]] ResolveDefaultComparison () {
        [string]$osKind = [RuntimeOSContext]::CurrentPlatform()
        [IOPathStrategyKind]$strategy = [IOPathPolicy]::DecideStrategy($osKind)
        switch ($strategy) {
            ([IOPathStrategyKind]::Windows) {
                return [IOPathWindowsConstraints]::GetDefaultComparison()
            }
            ([IOPathStrategyKind]::Linux) {
                return [IOPathLinuxConstraints]::GetDefaultComparison()
            }
            ([IOPathStrategyKind]::MacOS) {
                return [IOPathMacOSConstraints]::GetDefaultComparison()
            }
            # Unknown
            default {
                throw [System.PlatformNotSupportedException]::new('Unsupported os in ResolveDefaultComparison.')
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in ResolveDefaultComparison.'
        )
    }
    
    static [string[]] ResolveInvalidTokens () {
        [string]$osKind = [RuntimeOSContext]::CurrentPlatform()
        [IOPathStrategyKind]$strategy = [IOPathPolicy]::DecideStrategy($osKind)
        switch ($strategy) {
            Windows {
                return [IOPathWindowsConstraints]::GetInvalidTokens()
            }
            Linux {
                return [IOPathLinuxConstraints]::GetInvalidTokens()
            }
            MacOS {
                return [IOPathMacOSConstraints]::GetInvalidTokens()
            }
            # Unknown
            default {
                throw [System.PlatformNotSupportedException]::new('Unsupported os in ResolveInvalidTokens.')
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in ResolveInvalidTokens.'
        )
    }
    
    static [string[]] ResolveExclusiveInvalidTokens () {
        [string]$osKind = [RuntimeOSContext]::CurrentPlatform()
        [IOPathStrategyKind]$strategy = [IOPathPolicy]::DecideStrategy($osKind)
        switch ($strategy) {
            Windows {
                return [IOPathWindowsConstraints]::GetExclusiveInvalidTokens()
            }
            Linux {
                return [IOPathLinuxConstraints]::GetExclusiveInvalidTokens()
            }
            MacOS {
                return [IOPathMacOSConstraints]::GetExclusiveInvalidTokens()
            }
            # Unknown
            default {
                throw [System.PlatformNotSupportedException]::new('Unsupported os in ResolveExclusiveInvalidTokens.')
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in ResolveExclusiveInvalidTokens.'
        )
    }
    
    static [int] ResolveMaxLengthLimitForSegment () {
        [string]$osKind = [RuntimeOSContext]::CurrentPlatform()
        [IOPathStrategyKind]$strategy = [IOPathPolicy]::DecideStrategy($osKind)
        switch ($strategy) {
            Windows {
                return [IOPathWindowsConstraints]::GetSegmentMaxLengthLimit()
            }
            Linux {
                return [IOPathLinuxConstraints]::GetSegmentMaxLengthLimit()
            }
            MacOS {
                return [IOPathMacOSConstraints]::GetSegmentMaxLengthLimit()
            }
            # Unknown
            default {
                throw [System.PlatformNotSupportedException]::new('Unsupported os in ResolveMaxLengthLimitForSegment.')
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in ResolveMaxLengthLimitForSegment.'
        )
    }
    
    static [int] ResolveMaxLengthLimit () {
        [string]$osKind = [RuntimeOSContext]::CurrentPlatform()
        [IOPathStrategyKind]$strategy = [IOPathPolicy]::DecideStrategy($osKind)
        switch ($strategy) {
            Windows {
                return [IOPathMaxLengthWindowsResolver]::ResolveEffectivePathMaxLimit(
                    [IOPathWindowsConstraints]::GetLegacyMaxLengthLimit(),
                    [IOPathWindowsConstraints]::GetMaxLengthLimit()
                )
            }
            Linux {
                return [IOPathLinuxConstraints]::GetMaxLengthLimit()
            }
            MacOS {
                return [IOPathMacOSConstraints]::GetMaxLengthLimit()
            }
            # Unknown
            default {
                throw [System.PlatformNotSupportedException]::new('Unsupported os in ResolveMaxLengthLimit.')
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in ResolveMaxLengthLimit.'
        )
    }
    
}