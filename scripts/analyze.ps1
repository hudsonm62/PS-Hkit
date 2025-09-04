Invoke-ScriptAnalyzer -Path (Join-Path '.' -childpath 'src/Hkit') -Recurse -Settings 'PSScriptAnalyzerSettings.psd1' -ReportSummary
