Get-ChildItem -Path (Join-Path $PSScriptRoot "../src/Hkit") -Recurse -Force -Filter "*.ps1" -ErrorAction Stop | ForEach-Object {
    . $_.FullName
}
