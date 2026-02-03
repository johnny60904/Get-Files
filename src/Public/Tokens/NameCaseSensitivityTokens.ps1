
class NameCaseSensitivityTokens {
    
    hidden static [System.StringComparison] $Comparison = [System.StringComparison]::OrdinalIgnoreCase
    
    hidden static [string[]] $Allowed = @('Auto', 'Sensitive', 'Insensitive')
    
}