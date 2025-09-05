Invoke-ScriptAnalyzer -Path (Join-Path $PSScriptRoot -childpath '../src/Hkit') -Recurse -Settings 'PSScriptAnalyzerSettings.psd1' -ReportSummary
