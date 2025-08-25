<#
.DESCRIPTION
    Gets the current system uptime. Mainly for PS5.1, since Get-Uptime was added in PS6.
#>
function Get-Uptime {
    param(
        [switch]$Since = $false
    )
    if($PSVersionTable.PSVersion.Major -ge 6) {
        return Get-Uptime -Since:$Since # Get-Uptime was added in PS6
    } else {
        $LastBootTime = (Get-CimInstance -ClassName Win32_OperatingSystem -Property LastBootUpTime).LastBootUpTime
        if($Since){ return $LastBootTime }
        return ((Get-Date) - $LastBootTime)
    }
}

Set-Alias -Name uptime -Value Get-Uptime
