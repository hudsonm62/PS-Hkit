function Get-WindowsDisplayVersion {
    Assert-WindowsDevice -ErrorAction Stop
    return Get-ItemPropertyValue -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name DisplayVersion
}
