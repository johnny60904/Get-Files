[string[]]$ExcludedFileAttributesAllowed = [SkipFileAttributesTokens]::Allowed
[System.StringComparison]$ExcludedFileAttributesComparison = [SkipFileAttributesTokens]::Comparison
[string[]]$MatchCaseSensitivityAllowed = [NameCaseSensitivityTokens]::Allowed
[System.StringComparison]$MatchCaseSensitivityComparison = [NameCaseSensitivityTokens]::Comparison

function New-DiscoveredFilesSetOptions {
# TODO: Add Comment-Based Help
    [CmdletBinding()]
    # 此函式只是為了獲得 options 而已, 一般如 js 那般函式使用方式即可, 不支援 pipeline, 下面會 Assert
    param(
        
        [Parameter(Position = 0)]
        [bool] $ContinueOnAccessDenied = $true,
        
        [Parameter(Position = 1)]
        [ValidateScript({
            [NumericValidators]::ValidateNonNegtiveInteger($_, 'IOBufferSize')
            return $true
        })]
        [int] $IOBufferSize = 0,
        
        [Parameter(Position = 2)]
        [ValidateScript({
            [StringValidators]::ValidateIsOneOf(
                $_,
                $ExcludedFileAttributesAllowed,
                $ExcludedFileAttributesComparison,
                'ExcludedFileAttributes'
            )
            return $true
        })]
        [string[]] $ExcludedFileAttributes = @('Hidden', 'System'),
        
        [Parameter(Position = 3)]
        [ValidateScript({
            [StringValidators]::ValidateIsOneOf(
                $_,
                $MatchCaseSensitivityAllowed,
                $MatchCaseSensitivityComparison,
                'MatchCaseSensitivity'
            )
            return $true
        })]        
        [string] $MatchCaseSensitivity = 'Auto'
    )
    if ($MyInvocation.ExpectingInput) {
        [System.InvalidOperationException]$excp = [System.InvalidOperationException]::new(
            "This Cmdlet does NOT support pipeline input."
        )
        [System.Management.Automation.ErrorRecord]$err = [ErrorRecordFactory]::FromException(
            $excp,
            'PipelineNotSupported',
            [System.Management.Automation.ErrorCategory]::InvalidOperation,
            $null
        )
        $PSCmdlet.ThrowTerminatingError($err)
    }
    try { # 會驗證參數合法性 (AssertXXX -> 錯直接噴錯), 因此 try
        [TraversalOptions]$traversalOptions = [DiscoveryOptionsFactory]::MapOptions(
            $ContinueOnAccessDenied,
            $IOBufferSize,
            $ExcludedFileAttributes,
            $MatchCaseSensitivity
        )
        return [TraversalOptions]$traversalOptions
    } catch [ApplicationException] {
        [System.Management.Automation.ErrorRecord]$err = [ErrorRecordFactory]::FromException(
            $_.Exception,
            'UseCaseComponentFailed',
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