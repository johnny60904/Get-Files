class ArgumentErrorDiagnosticFormatter {
    
    static [string] FormatCharHexDiagnostic (
        [char] $value,
        [string] $hexFormat,
        [string] $diagnosticFormat
    ) {
        [System.Globalization.CultureInfo]$culture = [RuntimeOSContext]::CurrentCulture()
        [string]$hex = [CharFormatter]::FormatChar($value, $culture, $hexFormat)
        return [System.String]::Format($diagnosticFormat, $value, $hex)
    }
    
    static [string] FormatInvalidCharsDiagnostic (
        [char[]] $invalidValues,
        [string] $itemFormat,
        [string] $separator,
        [string] $diagnosticFormat
    ) {
        [string]$diagnosticText =  [CharFormatter]::FormatCharsListWithCodes(
            $invalidValues,
            $itemFormat,
            $separator
        )
        return [System.String]::Format($diagnosticFormat, $diagnosticText)
    }
    
    static [string] FormatMaxLimitDiagnostic (
        [int] $maxLimit,
        [string] $diagnosticFormat
    ) {
        [string]$aprxSymbol = [SymbolResolver]::ResolveSymbolAlias('aprx')
        return [System.String]::Format($diagnosticFormat, $aprxSymbol, $maxLimit)
    }
    
    static [string] FormatAllowedValuesDiagnostic (
        [string[]] $values,
        [string] $separator,
        [System.StringComparison] $comparison,
        [string] $format
    ) {
        [string]$comparisonDesc = [StringComparisonInspector]::DescribeCaseSensitivity($comparison)
        [string]$joined = [CollectionsMerger]::JoinStringArray($values, $separator)
        return [System.String]::Format($format, $comparisonDesc, $joined)
    }
}