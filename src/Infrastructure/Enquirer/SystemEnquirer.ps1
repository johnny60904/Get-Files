class SystemEnquirer {
    
    static [System.Globalization.CultureInfo] GetCurrentCulture () {
        return [System.Globalization.CultureInfo]::CurrentCulture
    }
    
    static [System.Globalization.CultureInfo] GetCurrentUICulture () {
        return [System.Globalization.CultureInfo]::CurrentUICulture
    }
    
    static [string] GetOSKind () {
        $runtime = [System.Runtime.InteropServices.RuntimeInformation]
        $platform = [System.Runtime.InteropServices.OSPlatform]
        if ($runtime::IsOSPlatform($platform::Windows)) {
            return 'Windows'
        } elseif ($runtime::IsOSPlatform($platform::Linux)) {
            return 'Linux'
        } elseif ($runtime::IsOSPlatform($platform::OSX)) {
            return 'MacOS'
        } else {
            return 'Unknown'
        }
    }
    
    # (Windows 限定) 確認是否啟用 Long Paths -> 0: disabled; 1: enabled
    static [bool] IsLongPathEnabled () { # 
        # Linux ('/' 正斜線系統) / MaxOS 都沒有 regedit
        [string]$regPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem'
        [int]$flag = (Get-ItemProperty $regPath).LongPathsEnabled
        return [System.Convert]::ToBoolean($flag)
    }
    
}