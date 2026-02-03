class RuntimeOSContext {
    
    static [System.Globalization.CultureInfo] CurrentCulture () {
        return [SystemEnquirer]::GetCurrentCulture()
    }
    
    static [System.Globalization.CultureInfo] CurrentUICulture () {
        return [SystemEnquirer]::GetCurrentUICulture()
    }
    
    static [string] CurrentPlatform () {
        return [SystemEnquirer]::GetOSKind()
    }
    
}