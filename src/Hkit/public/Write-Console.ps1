<#
.SYNOPSIS
    Writes a message to the console with a specified level of importance.
.NOTES
    - Uses Write-Information for INFO level
.LINK
    https://github.com/PowerShell/PSScriptAnalyzer/issues/1118#issuecomment-451183867
#>
function Write-Console {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [string]$Message,
        [Parameter(Position = 1)][ValidateSet("INFO", "WARNING", "DEBUG", "ERROR", "CRITICAL")]
        [string]$Level = "INFO"
    )

    process {
        switch ($Level) {
            "INFO" { Write-Information "$Message" -InformationAction Continue }
            "WARNING" { Write-Warning "$Message" }
            "DEBUG" { Write-Debug "$Message" }
            "ERROR" { Write-Error "$Message" }
            "CRITICAL" { throw "$Message" }
        }
    }
}
