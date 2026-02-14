class ErrorRecordFactory {
    
    static [System.Management.Automation.ErrorRecord] CreateFromException (
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
    
    static [System.Management.Automation.ErrorRecord] CreateFromApplicationException (
        [ApplicationException] $exception
    ) {
        [System.Management.Automation.ErrorRecord]$err = New-Object System.Management.Automation.ErrorRecord -ArgumentList @(
            $exception, # exception
            ([ErrorIdResolver]::ResolveFromApplicationException($exception)), # id
            ([ErrorCategoryResolver]::ResolveFromReason($exception.Reason)), # category
            $exception.TargetObject # target
        )
        $err.ErrorDetails = New-Object System.Management.Automation.ErrorDetails(
            ([ErrorMessageFormatter]::FormateFromApplicationException($exception))
        )
        return $err
    }
    
}