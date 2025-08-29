<#
.DESCRIPTION
    Gets the current system uptime. Mainly for PS5.1, since Get-Uptime was added in PS6.

    Calls the original Get-Uptime cmdlet in PS6+, otherwise falls back to a custom implementation that functions identically.
#>
function Get-Uptime {
    [CmdletBinding()]
    param(
        [switch]$Since
    )
    if($PSVersionTable.PSVersion.Major -ge 6) {
        return Microsoft.PowerShell.Utility\Get-Uptime @PSBoundParameters # Get-Uptime was added in PS6
    } else {
        $LastBootTime = (Get-CimInstance -ClassName Win32_OperatingSystem -Property LastBootUpTime).LastBootUpTime
        if($Since){ return $LastBootTime }
        return ((Get-Date) - $LastBootTime)
    }
}

Set-Alias -Name uptime -Value Get-Uptime
