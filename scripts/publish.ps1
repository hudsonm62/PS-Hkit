param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    $APIKey = $env:PSGALLERY_KEY,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$Path,

    # if specified, the module will be published as a prerelease
    [Parameter()]
    [string]$PreReleaseString
)

# validation
Resolve-Path $Path -ErrorAction Stop | Out-Null
$DataFile = Join-Path -Path $Path -ChildPath 'Hkit.psd1'
$Manifest = Test-ModuleManifest -Path $DataFile -ErrorAction Stop

$parameters = @{
    AllowPrerelease = $false
    Path            = $Path
    NuGetApiKey     = "$APIKey"
    Repository      = "PSGallery"
}

if ($PreReleaseString) {
    # add prerelease string if specified
    $parameters['AllowPrerelease'] = $true
    Update-ModuleManifest -Path $DataFile -PrivateData @{ Prerelease = $PreReleaseString } -ErrorAction Stop

    $v = "$($Manifest.Version)-$PreReleaseString"
} else { $v = "$($Manifest.Version)" }

# publish
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
Publish-Module @parameters `
    -ErrorAction Stop -WarningAction Stop

Write-Information -InformationAction Continue -MessageData "$($Manifest.Name) $v published successfully to PSGallery!"

#Requires -Version 7
#Requires -Module PowerShellGet
## Requires PS7 since PS5 cannot add the Prerelease field to the manifest :(
