class TraversalDepthStrategyMapper {
    
    hidden static [string] $Component = 'TraversalDepthStrategyMapper'
    
    static [string] FromSwitchFlag (
        [switch] $flag
    ) {
        return [SwitchSelector]::Select(
            $flag,
            [TraversalDepthStrategyIdentifierNames]::InfinityName,
            [TraversalDepthStrategyIdentifierNames]::CurrentLevelOnlyName
        )
    }
    
}