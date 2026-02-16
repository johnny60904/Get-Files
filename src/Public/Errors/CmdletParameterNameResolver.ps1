class CmdletParameterNameResolver {
    
    static [CmdletParameter] ResolveFromFieldName (
        [ApplicationParameter] $fieldName
    ) {
        switch ($fieldName) {
            ([ApplicationParameter]::TraversalStrategy) {
                return [CmdletParameter]::DepthFirst
            }
            ([ApplicationParameter]::TraversalScope) {
                return [CmdletParameter]::Recurse
            }
            ([ApplicationParameter]::SkipFileAttribute) {
                return [CmdletParameter]::ExcludeAttributes
            }
            ([ApplicationParameter]::SkipFileAttributes) {
                return [CmdletParameter]::ExcludeAttributes
            }
            ([ApplicationParameter]::NameCaseSensitivity) {
                return [CmdletParameter]::CaseSensitivity
            }
            ([ApplicationParameter]::TraversalOptions) {
                return [CmdletParameter]::Operation
            }
            ([ApplicationParameter]::InputPaths) {
                return [CmdletParameter]::Operation
            }
            ([ApplicationParameter]::TraversalOperation) {
                return [CmdletParameter]::Operation
            }
            ([ApplicationParameter]::DiscoveryRequest) {
                return [CmdletParameter]::Operation
            }
            default {
                throw [System.InvalidOperationException]::new(
                    'Unknown identifier name for [ApplicationParameter] in ResolveFromApplicationParameterName.'
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in ResolveFromApplicationParameterName.'
        )
    }
    
}