[string[]]$ExcludedFileAttributesAllowed = [SkipFileAttributesTokens]::Allowed
[System.StringComparison]$ExcludedFileAttributesComparison = [SkipFileAttributesTokens]::Comparison

function New-FilesAdvancedOptions {
# TODO: Add Comment-Based Help
    [CmdletBinding()]
    # 此函式只是為了獲得 options 而已, 一般如 js 那般函式使用方式即可, 不支援 pipeline, 下面會 Validate
    param(
        
        [Parameter(Position = 0)]
        [ValidateScript({
            [NumericValidators]::ValidateNonNegtiveInteger($_, 'BufferSizeKB')
            return $true
        })]
        [int] $BufferSizeKB = 0, # IOBufferSize
        
        [Parameter(Position = 1)]
        [ValidateScript({
            [StringValidators]::ValidateIsOneOf(
                $_,
                $ExcludedFileAttributesAllowed,
                $ExcludedFileAttributesComparison,
                'ExcludeAttributes'
            )
            return $true
        })]
        [string[]] $ExcludeAttributes = @('Hidden', 'System') # ExcludedFileAttributes
        
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
    return [FilesAdvancedOptions]::new(
        $BufferSizeKB,
        $ExcludeAttributes
    )
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