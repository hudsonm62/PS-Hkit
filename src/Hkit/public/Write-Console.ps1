function Write-Console {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Message,
        [Parameter()][ValidateSet("INFO", "WARNING", "ERROR", "CRITICAL")]
        [string]$Level = "INFO"
    )

    switch ($Level) {
        "INFO" { Write-Information "$Message" -InformationAction Continue }
        "WARNING" { Write-Warning "$Message" }
        "ERROR" { Write-Error "$Message" }
        "CRITICAL" { throw "$Message" }
        default { Write-Information "$Message" -InformationAction Continue }
    }
}
