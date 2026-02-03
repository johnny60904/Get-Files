class IOPathMaxLengthResolver {
    
    static [int] ResolveEffectiveMaxLength () {
        [int]$theoreticalMaxLimit = [IOPathConstraintsResolver]::ResolveMaxLengthLimit()
        return [IOPathMaxLengthProbe]::ProbeEffectiveMaxLength($theoreticalMaxLimit)
    }
    
}