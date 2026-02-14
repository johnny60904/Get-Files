class NameCaseSensitivityConverter  {
    
    static [System.IO.MatchCasing] ToMatchCasing (
        [NameCaseSensitivity] $casingType # Auto, Sensitive, Insensitive
    ) {
        switch ($casingType) {
            ([NameCaseSensitivity]::Auto) {
                return [System.IO.MatchCasing]::PlatformDefault
            }
            ([NameCaseSensitivity]::Sensitive) {
                return [System.IO.MatchCasing]::CaseSensitive
            }
            ([NameCaseSensitivity]::Insensitive) {
                return [System.IO.MatchCasing]::CaseInsensitive
            }
            default {
                throw [System.InvalidOperationException]::new(
                    "Unknown identifier name '$($casingType.ToString())' for [NameCaseSensitivity] in ToMatchCasing."
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in ToMatchCasing.'
        )
    }
    
}