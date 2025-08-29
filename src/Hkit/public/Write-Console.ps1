<#
.LINK
    https://github.com/PowerShell/PSScriptAnalyzer/issues/1118
#>
function Write-Console {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [string]$Message,
        [Parameter(Position = 1)][ValidateSet("INFO", "WARNING", "ERROR", "CRITICAL")]
        [string]$Level = "INFO"
    )

    process {
        switch ($Level) {
            "INFO" { Write-Information "$Message" -InformationAction Continue }
            "WARNING" { Write-Warning "$Message" }
            "ERROR" { Write-Error "$Message" }
            "CRITICAL" { throw "$Message" }
            default { Write-Information "$Message" -InformationAction Continue }
        }
    }
}
