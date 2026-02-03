class IOPathMaxLengthWindowsResolver {
    
    static [int] ResolveEffectivePathMaxLimit (
        [int] $legacyMaxLimit,
        [int] $longPathMaxLimit
    ) {
        if ([SystemEnquirer]::IsLongPathEnabled()) {
            return $longPathMaxLimit
        }
        return $legacyMaxLimit
    }
    
}