
function Get-Files {
# TODO: Add Comment-Based Help
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateScript({
            [IOPathSyntaxValidators]::ValidateAbsolutePathSyntax($_, 'Path')
            [FileSystemStateValidators]::ValidateDirectoryExistence($_, 'Path')
            return $true
        })]
        [string] $Path, # DirectoryPath
        
        # 可空 (不指定), 就變成遍歷並收集 $Path 下所有檔案
        [Parameter(Position = 1)]
        [ValidateScript({
            if ([IOPathSegmentValidators]::ValidateIsNullOrEmpty($_)) { return $true }
            [IOPathSegmentValidators]::ValidateFolderNameSyntax($_, 'FilterNames')
            return $true
        })]
        [string[]] $FilterNames = @(), # ChildNames
        
        # 因為是 Files 用, 所以要求有附檔名, 即格式: xxx.xxx / 特例允許 *.* / *.<xxx> / <xxx>.*
        [Parameter(Position = 2)]
        [ValidateScript({
            [FileFilterPatternValidators]::ValidateFileFilterPattern($_, 'Filter')
            return $true
        })]
        [string] $Filter = "*.*", # FileFilter
        
        # 基本上在 New-Files*Options 那邊都 Validate 完了, 所以這邊應該就不處理了
        # 頂多使用者亂傳 hashtable / pscustomobject 之類的, 無法轉換成 FilesOptions,
        # 但也會 powershell 原生自動噴錯, 等於第一層防護了
        
        [Parameter(Position = 3)]
        [FilesOptions] $Options = (New-FilesOptions),
        
        [Parameter(Position = 4)]
        [FilesAdvancedOptions] $Advanced = (New-FilesAdvancedOptions),
        
        [Parameter()]
        [switch] $Recurse,
        
        [Parameter()]
        [switch] $DepthFirst,
        
        [Parameter()]
        [switch] $ExcludeHidden,
        
        [Parameter()]
        [switch] $ExcludeSystem,
        
        [Parameter()]
        [switch] $ExcludeReadonly
        
    )
    [bool]$RecurseFlag = if ($Recurse.IsPresent) { $true } else { $false }
    [bool]$DepthFirstFlag = if ($DepthFirst.IsPresent) { $true } else { $false }
    [bool]$ExcludeHiddenFlag = if ($ExcludeHidden.IsPresent) { $true } else { $false }
    [bool]$ExcludeSystemFlag = if ($ExcludeSystem.IsPresent) { $true } else { $false }
    [bool]$ExcludeReadonlyFlag = if ($ExcludeReadonly.IsPresent) { $true } else { $false }
    try {
        [TraversalOptions]$traversalOptions = [DiscoveryOptionsMapper]::Map(
            $Options.IgnoreErrors,
            $Options.CaseSensitivity,
            $Advanced.BufferSizeKB,
            $ExcludeHiddenFlag,
            $ExcludeSystemFlag,
            $ExcludeReadonlyFlag,
            $Advanced.ExcludeAttributes
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
        [DiscoveryRequest]$request = [DiscoveryRequestMapper]::Map(
            $Path,
            $FilterNames,
            $Filter,
            $traversalOptions,
            $RecurseFlag,
            $DepthFirstFlag
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