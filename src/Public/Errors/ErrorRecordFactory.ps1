class ErrorRecordFactory {
    
    static [System.Management.Automation.ErrorRecord] FromException (
        [System.Exception] $excp,
        [string] $errID,
        [System.Management.Automation.ErrorCategory] $errCate,
        [object] $errTarg
    ) {
        [System.Management.Automation.ErrorRecord]$err = New-Object System.Management.Automation.ErrorRecord -ArgumentList @(
            $excp,
            $errID,
            $errCate,
            $errTarg
        )
        # $err.ErrorDetails = New-Object System.Management.Automation.ErrorDetails($msg)
        return $err
    }
    
}