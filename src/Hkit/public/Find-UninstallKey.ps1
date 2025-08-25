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
