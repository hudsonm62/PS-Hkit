<#
Checks if the current device is indeed Windows-based, otherwise throws an error.
#>
function Assert-WindowsDevice {
    [CmdletBinding()]
    param(
        [string]$Message = "This can only be run on Windows-based devices."
    )
    if (
            $PSVersionTable.PSVersion.Major -ge 6 -and
            ($IsLinux -or $IsMacOS)
        ) {
        throw $Message
    }
}
