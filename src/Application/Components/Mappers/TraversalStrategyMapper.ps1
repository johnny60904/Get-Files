class TraversalStrategyMapper {
    
    hidden static [string] $Component = 'TraversalStrategyMapper'
    
    static [string] FromSwitchFlag (
        [switch] $flag
    ) {
        return [SwitchSelector]::Select(
            $flag,
            [TraversalStrategyIdentifierNames]::DepthFirstName,
            [TraversalStrategyIdentifierNames]::BreadthFirstName
        )
    }
    
}