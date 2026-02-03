class CharFormatter {
    
    static [string] FormatChar (
        [char] $char,
        [System.Globalization.CultureInfo]$culture,
        [string] $format
    ) {
        return $char.ToString($format, $culture)
    }
    
    static [string] FormatCharsListWithCodes (
        [char[]] $chars,
        [string] $itemFormat,
        [string] $separator
    ) {
        [string]$textFormat = $itemFormat + $separator
        $sb = [System.Text.StringBuilder]::new()
        for ($i = 0; $i -lt $chars.Length; $i ++) {
            [char]$char = $chars[$i]
            [void]$sb.AppendFormat($textFormat, $char, [int]$char)
        }
        [string]$text = $sb.ToString()
        [int]$redundant = $text.Length - $separator.Length
        [string]$trimedText = $text.Remove($redundant)
        return $trimedText
    }
    
}