
function Get-Files {
# TODO: Add Comment-Based Help
    [CmdletBinding()]
    param(
        
        # ------------------ 核心參數 ------------------
        
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateScript({
            [IOPathSyntaxValidators]::ValidateAbsolutePathSyntax($_, 'Path')
            [FileSystemStateValidators]::ValidateDirectoryExistence($_, 'Path')
            return $true
        })]
        [string] $Path, # DirectoryPath
        
        # ------------------ 共用參數 ------------------
        
        [ValidateScript({
            [FileNamePatternValidators]::ValidateFileNamePattern($_, 'Exclude')
            return $true
        })]
        [string[]] $Exclude, # ExcludeNames
        
        [ValidateScript({
            [FileNamePatternValidators]::ValidateFileNamePattern($_, 'Filter')
            return $true
        })]
        [string] $Filter = "*", # FileFilter
        
        [switch] $Recurse,
        
        # ------------------ Default switches ------------------
        
        [switch] $ExcludeHidden,
        
        [switch] $ExcludeSystem,
        
        [switch] $ExcludeReadonly,
        
        # ------------------ Options 相合組合 / 不互斥 ------------------
        # ------------------------------------------------
        # 基本上在 New-Files*Options 那邊都 Validate 完了, 所以這邊應該就不處理了
        # 頂多使用者亂傳 hashtable / pscustomobject 之類的, 無法轉換成 FilesOptions,
        # 但也會 powershell 原生自動噴錯, 等於第一層防護了
        # ------------------------------------------------
        
        [FilesOptions] $Options = (New-FilesOptions),
        
        [FilesAdvancedOptions] $Advanced = (New-FilesAdvancedOptions)
        
    )
    begin {
        [bool]$RecurseFlag = if ($Recurse.IsPresent) { $true } else { $false }
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
            [System.Management.Automation.ErrorRecord]$err = [ErrorRecordFactory]::CreateFromApplicationException(
                $_.Exception
            )
            $PSCmdlet.ThrowTerminatingError($err)
        }
    }
    process {
        
        try {
            [DiscoveryRequest]$request = [DiscoveryRequestMapper]::Map(
                $Path,
                $Exclude,
                $Filter,
                $traversalOptions,
                $RecurseFlag,
                $Options.RecurseMode
            )
        } catch [ApplicationException] {
            [System.Management.Automation.ErrorRecord]$err = [ErrorRecordFactory]::CreateFromApplicationException(
                $_.Exception
            )
            $PSCmdlet.ThrowTerminatingError($err)
        }
        [DiscoverStructuredFilesSet]$useCase = [DiscoverStructuredFilesSet]::new($request)
        try {
            & $useCase.Execute()
        } catch [ApplicationException] {
            [System.Management.Automation.ErrorRecord]$err = [ErrorRecordFactory]::CreateFromApplicationException(
                $_.Exception
            )
            $PSCmdlet.ThrowTerminatingError($err)
        }
    }
    end {
        
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