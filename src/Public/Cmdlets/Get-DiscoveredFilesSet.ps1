[string[]]$TraversalModeAllowed = [TraversalStrategyTokens]::Allowed
[System.StringComparison]$TraversalModeComparison = [TraversalStrategyTokens]::Comparison

function Get-DiscoveredFilesSet {
# TODO: Add Comment-Based Help
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateScript({
            [IOPathSyntaxValidators]::ValidateAbsolutePathSyntax($_, 'DirectoryPath')
            [FileSystemStateValidators]::ValidateDirectoryExistence($_, 'DirectoryPath')
            return $true
        })]
        [string] $DirectoryPath, # DirectoryPath
        
        # 可空 (不指定), 就變成遍歷並收集 $DirectoryPath 下所有檔案
        [Parameter(Position = 1)]
        [ValidateScript({
            if ([IOPathSegmentValidators]::ValidateIsNullOrEmpty($_)) { return $true }
            [IOPathSegmentValidators]::ValidateFolderNameSyntax($_, 'ChildNames')
            return $true
        })]
        [string[]] $ChildNames = @(), # ChildNames
        
        [Parameter()]
        # Validate removed
        [switch] $Recurse, # TraversalMode
        
        # 因為是 Files 用, 所以要求有附檔名, 即格式: xxx.xxx
        [Parameter(Position = 3)]
        [ValidateScript({
            [FileFilterPatternValidators]::ValidateFileFilterPattern($_, 'FileFilter')
            return $true
        })]
        [string] $FileFilter = "*.*", # FileFilter
        
        [Parameter()]
        [switch] $DepthFirst, # RecursionDepthMode
        
        # 基本上在 New-DiscoveredFilesSetOptions 那邊都 Validate 完了, 所以這邊應該就不處理了
        # 頂多使用者亂傳 hashtable / pscustomobject 之類的, 無法轉換成 TraversalOptions,
        # 但也會 powershell 原生自動噴錯, 等於第一層防護了
        [Parameter(Position = 5)]
        [FilesOptions] $Options = (New-DiscoveredFilesSetOptions)
    )
    try {
        [TraversalOptions]$traversalOptions = [DiscoveryOptionsMapper]::Map(
            $Options.ContinueOnAccessDenied,
            $Options.IOBufferSize,
            $Options.ExcludedFileAttributes,
            $Options.MatchCaseSensitivity
        )
    } catch [ApplicationException] {
        [System.Management.Automation.ErrorRecord]$err = [ErrorRecordFactory]::FromException(
            $_.Exception,
            'UseCaseComponentFailed',
            [System.Management.Automation.ErrorCategory]::InvalidOperation,
            $null
        )
        $PSCmdlet.ThrowTerminatingError($err)
    }
    try {
        [DiscoveryRequest]$request = [DiscoveryRequestFactory]::Map(
            $DirectoryPath,
            $ChildNames,
            $Recurse,
            $FileFilter,
            $DepthFirst,
            $traversalOptions
        )
    } catch [ApplicationException] {
        [System.Management.Automation.ErrorRecord]$err = [ErrorRecordFactory]::FromException(
            $_.Exception,
            'UseCaseComponentFailed',
            [System.Management.Automation.ErrorCategory]::InvalidOperation,
            $null
        )
        $PSCmdlet.ThrowTerminatingError($err)
    }
    [DiscoverStructuredFilesSet]$useCase = [DiscoverStructuredFilesSet]::new($request)
    try {
        [string[]]$discovered = ($useCase.Execute()).DiscoveredFiles
        return [string[]]$discovered
    } catch [ApplicationException] {
        [System.Management.Automation.ErrorRecord]$err = [ErrorRecordFactory]::FromException(
            $_.Exception,
            'UseCaseFailed',
            [System.Management.Automation.ErrorCategory]::InvalidOperation,
            $null
        )
        $PSCmdlet.ThrowTerminatingError($err)
    }
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