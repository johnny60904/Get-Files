class SymbolResolver {
    
    hidden static [string] ResolveSymbolAlias (
        [string] $alias
    ) {
        switch ($alias) {
            'aprx' { return [System.Char]::ConvertFromUtf32(0x2248) }
            'lt' { return [System.Char]::ConvertFromUtf32(0x003C) }
            'gt' { return [System.Char]::ConvertFromUtf32(0x003E) }
            'eq' { return [System.Char]::ConvertFromUtf32(0x003D) }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new("Unreachable code path in ResolveSymbolAlias.")
    }
    
}