function upper {
    param([string]$ipt)
    [string]$rlt = $ipt.ToUpper()
    return [string]$rlt
}