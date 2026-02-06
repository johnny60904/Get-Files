
function Get-Files {
# TODO: Add Comment-Based Help
    [CmdletBinding(DefaultParameterSetName = 'ByValue')]
    param(
        
        # ------------------ 核心參數 ------------------
        
        [Parameter(Mandatory, Position = 0, ParameterSetName = 'ByValue')]
        [ValidateScript({
            [IOPathSyntaxValidators]::ValidateAbsolutePathSyntax($_, 'Path')
            [FileSystemStateValidators]::ValidateDirectoryExistence($_, 'Path')
            return $true
        })]
        [string] $Path, # DirectoryPath
        
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'ByPipeline')]
        [ValidateScript({
            [IOPathSyntaxValidators]::ValidateAbsolutePathSyntax($_, 'InputPath')
            [FileSystemStateValidators]::ValidateDirectoryExistence($_, 'InputPath')
            return $true
        })]
        [string] $InputPath, # # DirectoryPath
        
        # ------------------ 共用參數 ------------------
        
        # 可空 (不指定), 就變成遍歷並收集 $Path 下所有檔案
        [Parameter(Position = 1, ParameterSetName = 'ByValue')]
        [Parameter(Position = 0, ParameterSetName = 'ByPipeline')]
        [ValidateScript({
            if ([IOPathSegmentValidators]::ValidateIsNullOrEmpty($_)) { return $true }
            [IOPathSegmentValidators]::ValidateFolderNameSyntax($_, 'FilterNames')
            return $true
        })]
        [string[]] $FilterNames = @(), # ChildNames
        
        # 因為是 Files 用, 所以要求有附檔名, 即格式: xxx.xxx / 特例允許 *.* / *.<xxx> / <xxx>.*
        [Parameter(Position = 2, ParameterSetName = 'ByValue')]
        [Parameter(Position = 1, ParameterSetName = 'ByPipeline')]
        [ValidateScript({
            [FileFilterPatternValidators]::ValidateFileFilterPattern($_, 'Filter')
            return $true
        })]
        [string] $Filter = "*.*", # FileFilter
        
        [Parameter()]
        [switch] $Recurse,
        
        [Parameter()]
        [switch] $DepthFirst,
        
        # ------------------ Default switches ------------------
        
        [Parameter()]
        [switch] $ExcludeHidden,
        
        [Parameter()]
        [switch] $ExcludeSystem,
        
        [Parameter()]
        [switch] $ExcludeReadonly,
        
        # ------------------ Options 相合組合 / 不互斥 ------------------
        # ------------------------------------------------
        # 基本上在 New-Files*Options 那邊都 Validate 完了, 所以這邊應該就不處理了
        # 頂多使用者亂傳 hashtable / pscustomobject 之類的, 無法轉換成 FilesOptions,
        # 但也會 powershell 原生自動噴錯, 等於第一層防護了
        # ------------------------------------------------
        
        [Parameter(Position = 3, ParameterSetName = 'ByValue')]
        [Parameter(Position = 2, ParameterSetName = 'ByPipeline')]
        [FilesOptions] $Options = (New-FilesOptions),
        
        [Parameter(Position = 4, ParameterSetName = 'ByValue')]
        [Parameter(Position = 3, ParameterSetName = 'ByPipeline')]
        [FilesAdvancedOptions] $Advanced = (New-FilesAdvancedOptions)
        
    )
    begin {
        [bool]$RecurseFlag = if ($Recurse.IsPresent) { $true } else { $false }
        [bool]$DepthFirstFlag = if ($DepthFirst.IsPresent) { $true } else { $false }
        [bool]$ExcludeHiddenFlag = if ($ExcludeHidden.IsPresent) { $true } else { $false }
        [bool]$ExcludeSystemFlag = if ($ExcludeSystem.IsPresent) { $true } else { $false }
        [bool]$ExcludeReadonlyFlag = if ($ExcludeReadonly.IsPresent) { $true } else { $false }
    }
    process {
        [string]$directory = $null
        switch ($PSCmdlet.ParameterSetName) {
            'ByValue' { [string]$directory = $Path }
            'ByPipeline' { [string]$directory = $InputPath }
            default {
                [System.InvalidOperationException]$excp = [System.InvalidOperationException]::new(
                    "Unknown parameter set in Get-Files."
                )
                [System.Management.Automation.ErrorRecord]$err = [ErrorRecordFactory]::FromException(
                    $excp,
                    'UnsupportedParameterSet',
                    [System.Management.Automation.ErrorCategory]::InvalidOperation,
                    $null
                )
                $PSCmdlet.ThrowTerminatingError($err)
            }
        }
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
                $directory,
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
    end {
        return [string[]]$discovered
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