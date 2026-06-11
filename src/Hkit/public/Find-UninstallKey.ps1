<#
.SYNOPSIS
    Searches registry for registered packages.

.DESCRIPTION
    Search registry for registered packages and software.

    WARNING: Not all software registers itself here, especially portable applications. Some applications may also not specify a DisplayName and/or UninstallString.

.PARAMETER Name
    DisplayName of Package - Wildcards are supported.
#>
function Find-UninstallKey {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)][ValidateNotNull()]
        [string]$Name
    )
    begin {
        Assert-WindowsDevice -ErrorAction Stop
    }
    process {
        return @(
                # User Locations
                "Registry::HKEY_CURRENT_USER\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
                "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall"

                # System Locations
                "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
                "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
            ) | ForEach-Object {
                if(Test-Path $_){
                    Get-ChildItem $_ | ForEach-Object {
                        Get-ItemProperty $_.PSPath
                    } | Where-Object {
                        $_.DisplayName -like "$Name"
                    }
                }
            }
    }
}
