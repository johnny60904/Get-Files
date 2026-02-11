
class ExcludeAttributesTokens {
    
    hidden static [System.StringComparison] $Comparison = [System.StringComparison]::OrdinalIgnoreCase
    
    hidden static [string[]] $Allowed = @(
            'None', 'Readonly', 'Hidden', 'System', 'Directory', 'Archive',
            'Device', 'Normal', 'Temporary', 'SparseFile', 'ReparsePoint', 'Compressed',
            'Offline', 'NotContentIndexed', 'Encrypted', 'IntegrityStream', 'NoScrubData'
        
        )
    
}