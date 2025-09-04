param(
    [switch]$NoBootstrap = $false,
    [switch]$CI = $false,
    [switch]$Diagnostics = $false
)
if(-not $NoBootstrap){
    $x = get-module Pester -ListAvailable | Where-Object Version -ge 5.7.1
    if(-not ($x)) {
        Install-Module -Name Pester -Force -SkipPublisherCheck
    }
}

$root = (Join-Path $PSScriptRoot '..')

[PesterConfiguration]$PesterConfig = New-PesterConfiguration
$PesterConfig.CodeCoverage.Path = (Join-Path $root 'src/Hkit')
$PesterConfig.Run.Exit = $false
$PesterConfig.TestResult.Enabled = $true
$PesterConfig.TestResult.OutputFormat = 'NUnitXml'
$PesterConfig.TestResult.OutputPath = (Join-Path $root 'testResults.xml')
$PesterConfig.TestDrive.Enabled = $false
$PesterConfig.TestRegistry.Enabled = $false

if($CI){
    $PesterConfig.CodeCoverage.Enabled = $true
    $PesterConfig.CodeCoverage.ExcludeTests = $true
    $PesterConfig.CodeCoverage.CoveragePercentTarget = 50
}
if($Diagnostics){
    $PesterConfig.Debug.WriteDebugMessages = $true
    $PesterConfig.Output.Verbosity = 'Diagnostic'
}

Invoke-Pester -Configuration $PesterConfig
