# using module GetFiles
using module ../../../GetFiles.psd1
# . "$PSScriptRoot/../../_PreLoad.ps1"

Describe 'TraversalOptions constructor' {
    
    Context 'when arguments are valid' {
        
        It 'Should create instance with expected property values' {
            
            $options = [TraversalOptions]::new(
                $true,
                [NameCaseSensitivity]::Auto,
                64,
                [SkipFileAttributes]::System
            )
            
            $options.SkipInaccessibleEntries | Should -BeTrue
            $options.NameCaseSensitivity | Should -Be ([NameCaseSensitivity]::Auto)
            $options.EntryReadBufferSize | Should -Be 64
            $options.SkipFileAttributes | Should -Be ([SkipFileAttributes]::System)
            
        }
        
    }
    
    Context 'when NameCaseSensitivity is invalid' {
        
        It 'Should throw DomainInvariantViolationException' {
            
            {
                [TraversalOptions]::new(
                    $true,
                    $null,
                    128,
                    [SkipFileAttributes]::Hidden
                )
            } | Should -Throw -ErrorType DomainInvariantViolationException
            
        }
        
    }
    
    Context 'when SkipFileAttributes is invalid' {
        
        It 'Should throw DomainInvariantViolationException' {
            
            {
                [TraversalOptions]::new(
                    $true,
                    [NameCaseSensitivity]::Auto,
                    256,
                    $null
                )
            } | Should -Throw -ErrorType DomainInvariantViolationException
            
        }
        
    }
    
}