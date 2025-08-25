<#
.PARAMETER Range
    IP Range to use (i.e. 10.1.1.0)
.PARAMETER Bitmask
    Bitmask to use (i.e. 24 for 256 IPs)
.DESCRIPTION
    Calculates the IP address range for a given range + bitmask and returns a list of usable IP addresses.
.EXAMPLE
    # returns range of IPs for the 192.168.1.0/24 block
    Get-CIDRHost -Range 192.168.1.0 -Bitmask 24
.NOTES
    Not a perfect implementation, but should work for most cases.
#>
function Get-CIDRHost {
    [OutputType([Object[]])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [System.Net.IPAddress]$Range,
        [Parameter()][ValidateRange(0,32)]
        [int]$Bitmask = 24
    )

    if($Bitmask -gt 32){
        Write-Warning "Bitmask cannot be greater than 32, defaulting to 32."
        $Bitmask = 32
    }
    if($Bitmask -lt 0){
        Write-Warning "Bitmask cannot be less than 0, defaulting to 0."
        $Bitmask = 0
    }

    # Convert IP to bytes and then to a 32-bit integer
    $IPBytes = $Range.GetAddressBytes()
    [Array]::Reverse($IPBytes) # Ensure correct byte order
    $IPInt = [BitConverter]::ToUInt32($IPBytes, 0)

    # Work out subnet size
    $HostBits = 32 - $Bitmask
    $NumAddresses = [math]::Pow(2, $HostBits)

    # Network address
    $NetworkInt = $IPInt -band ([uint32]::MaxValue -shl $HostBits)

    # Broadcast address
    $BroadcastInt = $NetworkInt + $NumAddresses - 1

    # Generate IP list (skip network and broadcast)
    [System.Net.IPAddress[]]$IPs = for ($i = $NetworkInt + 1; $i -lt $BroadcastInt; $i++) {
        $Bytes = [BitConverter]::GetBytes([uint32]$i)
        [Array]::Reverse($Bytes)
        [System.Net.IPAddress]::new($Bytes)
    }

    return $IPs
}
