# using module GetFiles
. "$PSScriptRoot/../_PreLoad.ps1"

$ErrorActionPreference = 'Stop'

# ================================== Test Commands ==================================

[System.Console]::WriteLine("`n`n=====================================`n`n")
[System.Console]::WriteLine("Get-Command:`n`n")

Get-Command New-FilesOptions
Get-Command New-FilesAdvancedOptions
Get-Command Get-Files

# ================================== Test Options ==================================

[System.Console]::WriteLine("`n`n=====================================`n`n")

$dft = New-FilesOptions
[System.Console]::WriteLine("`n`nNew-FilesOptions  Default:`n`n$(ConvertTo-Json $dft)")

$dftAdv = New-FilesAdvancedOptions
[System.Console]::WriteLine("`n`nNew-FilesAdvancedOptions  Default:`n`n$(ConvertTo-Json $dftAdv)")

$opt = New-FilesOptions -IgnoreErrors $false -CaseSensitivity 'Sensitive' -RecurseMode 'Breadth'
[System.Console]::WriteLine("`n`nNew-FilesOptions:`n`n$(ConvertTo-Json $opt)")

$optAdv = New-FilesAdvancedOptions -BufferSizeKB 64 -ExcludeAttributes @('Hidden', 'System', 'Archive', 'Device')
[System.Console]::WriteLine("`n`nNew-FilesAdvancedOptions:`n`n$(ConvertTo-Json $optAdv)")

[System.Console]::WriteLine("`n`n=====================================`n`n")

# ================================== Test Cmdlet (Traversal) ==================================

[string]$recurTestDirSha = [System.IO.Path]::GetFullPath([System.IO.Path]::Join($PSScriptRoot, '..', 'data', 'RecursionShallowTest'))
[string]$recurTestDir = [System.IO.Path]::GetFullPath([System.IO.Path]::Join($PSScriptRoot, '..', 'data', 'RecursionStructureTest'))

$OptionsDFS = New-FilesOptions -IgnoreErrors $true -CaseSensitivity 'Auto' -RecurseMode 'Depth'
$OptionsBFS = New-FilesOptions -IgnoreErrors $true -CaseSensitivity 'Auto' -RecurseMode 'Breadth'
$Advanced = New-FilesAdvancedOptions -BufferSizeKB 0 -ExcludeAttributes @('Hidden', 'System', 'ReadOnly')

try {
    [System.Console]::WriteLine("`n`nGet-Files Specified Shallow:`n`n")
    Get-Files -Path $recurTestDirSha
} catch {
    Write-Output $_
    Write-Output $_.Exception.InnerException
}

[System.Console]::WriteLine("`n`n=====================================`n`n")

try {
    [System.Console]::WriteLine("`n`nGet-Files Default:`n`n")
    Get-Files -Path $recurTestDir -Recurse
} catch {
    Write-Output $_
    Write-Output $_.Exception.InnerException
}

[System.Console]::WriteLine("`n`n=====================================`n`n")

try {
    [System.Console]::WriteLine("`n`nGet-Files DFS:`n`n")
    Get-Files -Path $recurTestDir -Recurse -Options $OptionsDFS
} catch {
    Write-Output $_
    Write-Output $_.Exception.InnerException
}

[System.Console]::WriteLine("`n`n=====================================`n`n")

try {
    [System.Console]::WriteLine("`n`nGet-Files BFS:`n`n")
    Get-Files -Path $recurTestDir -Recurse -Options $OptionsBFS
} catch {
    Write-Output $_
    Write-Output $_.Exception.InnerException
}

[System.Console]::WriteLine("`n`n=====================================`n`n")

try {
    [System.Console]::WriteLine("`n`nGet-Files DFS Switch Flags (System, ReadOnly):`n`n")
    Get-Files -Path $recurTestDir -Recurse -Options $OptionsDFS -ExcludeReadOnly -ExcludeSystem
} catch {
    Write-Output $_
    Write-Output $_.Exception.InnerException
}

[System.Console]::WriteLine("`n`n=====================================`n`n")

try {
    [System.Console]::WriteLine("`n`nGet-Files BFS Switch Flags (Hidden):`n`n")
    Get-Files -Path $recurTestDir -Recurse -Options $OptionsBFS -ExcludeHidden
} catch {
    Write-Output $_
    Write-Output $_.Exception.InnerException
}

[System.Console]::WriteLine("`n`n=====================================`n`n")

try {
    [System.Console]::WriteLine("`n`nGet-Files DFS Switch Pipeline (System, ReadOnly):`n`n")
    $recurTestDir | Get-Files -Recurse -Options $OptionsDFS -ExcludeReadOnly -ExcludeSystem
} catch {
    Write-Output $_
    Write-Output $_.Exception.InnerException
}

[System.Console]::WriteLine("`n`n=====================================`n`n")

try {
    [System.Console]::WriteLine("`n`nGet-Files BFS Switch Pipeline (Hidden):`n`n")
    $recurTestDir | Get-Files -Recurse -Options $OptionsBFS -ExcludeHidden
} catch {
    Write-Output $_
    Write-Output $_.Exception.InnerException
}

[System.Console]::WriteLine("`n`n=====================================`n`n")

try {
    [System.Console]::WriteLine("`n`nGet-Files BFS Switch Pipeline (Hidden) Exclude ('C'):`n`n")
    $recurTestDir | Get-Files -Recurse -Exclude @('C', 'C*.txt') -Options $OptionsBFS -ExcludeHidden
} catch {
    Write-Output $_
    Write-Output $_.Exception.InnerException
}

[System.Console]::WriteLine("`n`n=====================================`n`n")

try {
    [System.Console]::WriteLine("`n`nGet-Files DFS Switch Pipeline (Hidden) Exclude ('B'):`n`n")
    $recurTestDir | Get-Files -Recurse -Exclude @('B', 'B*.txt') -Options $OptionsDFS -ExcludeHidden
} catch {
    Write-Output $_
    Write-Output $_.Exception.InnerException
}

# ================================== Test Private (Traversal) ==================================

[System.Console]::WriteLine("`n`n=====================================`n`n")

Test-Engine

[System.Console]::WriteLine("`n`n=====================================`n`n")

Test-Selector

[System.Console]::WriteLine("`n`n=====================================`n`n")

Test-UseCase

[System.Console]::WriteLine("`n`n=====================================`n`n")

[System.Console]::WriteLine("`n`nDirect Cmdlet Get-Files Call - Current:`n`n")
Get-Files -Path $recurTestDir

[System.Console]::WriteLine("`n`n=====================================`n`n")

[System.Console]::WriteLine("`n`nDirect Cmdlet Get-Files Call - Recurse:`n`n")
Get-Files -Path $recurTestDir -Recurse -Options $OptionsDFS

[System.Console]::WriteLine("`n`n=====================================`n`n")

[System.Console]::WriteLine("`n`nDirect Cmdlet Get-Files Pipeline Call - Recurse:`n`n")
$recurTestDir | Get-Files -Recurse -Options $OptionsDFS

[System.Console]::WriteLine("`n`n=====================================`n`n")

[System.Console]::WriteLine("`n`nTest if true lazy - Recurse:`n`n") # 立刻停止 (只吐一個) -> lazy; 否則是 eager
$recurTestDir | Get-Files -Recurse -Options $OptionsDFS | Select-Object -First 1

[System.Console]::WriteLine("`n`n=====================================`n`n")

$ErrorActionPreference = 'Continue'

[System.Console]::WriteLine("`n`nPlease press ENTER to continue ...`n`n")
do {
    $keyInfo = [System.Console]::ReadKey($true)
} while ($keyInfo.Key -ne [System.ConsoleKey]::Enter)