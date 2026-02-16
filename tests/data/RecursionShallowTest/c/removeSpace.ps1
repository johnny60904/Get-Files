function removeSpace {
    param([string]$ipt)
    [string]$rlt = [System.Text.RegularExpressions.Regex]::Replace($ipt, "\s", '')
    return [string]$rlt
}