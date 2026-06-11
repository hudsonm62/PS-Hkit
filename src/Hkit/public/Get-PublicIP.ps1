<#
.SYNOPSIS
    Retrieves the public IPv4 address from ipify api. By default will return either a v4 or v6 IP depending on what's available.
.DESCRIPTION
    Retrieves the public IPv4 address from ipify api. The API uses the X-Forwarded-For header to determine the client's IP address, instead of a direct request somewhere.
.PARAMETER ForceIPv6
    Forces the retrieval of the public IP address using IPv6. Fails if IPv6 is not available.
#>
function Get-PublicIP {
    [CmdletBinding()]
    param (
        [Parameter()]
        [switch]$ForceIPv6
    )

    if ($ForceIPv6) {
        $uri = 'https://api64.ipify.org?format=json'
    } else {
        $uri = 'https://api.ipify.org?format=json'
    }

    $r = Invoke-RestMethod -Uri $uri -ErrorAction Stop
    return $r.ip
}
