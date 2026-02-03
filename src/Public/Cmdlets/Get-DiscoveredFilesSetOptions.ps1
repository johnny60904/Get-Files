function Get-DiscoveredFilesSetOptions {
# TODO: Add Comment-Based Help
    [CmdletBinding()]
    param()
    [TraversalOptions]$TraversalOptions = [DiscoveryOptionsFactory]::CreateDefaultOptions()
    return [TraversalOptions]$TraversalOptions
}
# (.SYNOPSIS)
# (.DESCRIPTION)
# (.OUTPUTS)
# (.EXAMPLE)
# (.SYNOPSIS: 概要說明。)
# (.DESCRIPTION: 詳細描述。)
# (.PARAMETER <參數名>: 說明特定參數的用法。)
# (.EXAMPLE: 範例程式碼，可多次出現。)
# (.INPUTS: 說明接受的輸入物件型別。)
# (.OUTPUTS: 說明輸出的物件型別。)
# (.NOTES: 補充備註。)
# (.LINK: 外部說明連結。)