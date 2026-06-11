<#
.SYNOPSIS
    Converts a byte value to a human readable format in the specified unit of measurement - Defaults to GB.
.DESCRIPTION
    Converts a byte value to a human readable format in the specified unit of measurement - Defaults to GB.
.PARAMETER Bytes
    The byte value to convert.
.PARAMETER DecimalPlaces
    The number of decimal places to round to. Ignored if -NoRounding is specified.
.PARAMETER NoRounding
    If specified, the output will not be rounded and DecimalPlaces will be ignored.
.PARAMETER KB
    Convert to Kilobytes.
.PARAMETER MB
    Convert to Megabytes.
.PARAMETER GB
    Convert to Gigabytes. (Default)
.PARAMETER TB
    Convert to Terabytes.
#>
function ConvertFrom-Bytes {
    [CmdletBinding(DefaultParameterSetName = 'GB')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'Checked via ParameterSetName')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [long]$Bytes,

        [Parameter(Position = 1)] # ignored if -NoRounding
        [int]$DecimalPlaces = 2,

        [Parameter()]
        [switch]$NoRounding = $false,

        [Parameter(ParameterSetName = 'KB')]
        [switch]$KB = $false,

        [Parameter(ParameterSetName = 'MB')]
        [switch]$MB = $false,

        [Parameter(ParameterSetName = 'GB')]
        [switch]$GB = $false,

        [Parameter(ParameterSetName = 'TB')]
        [switch]$TB = $false
    )
    process {
        $Size = switch($PSCmdlet.ParameterSetName){
            "KB" { 1KB ; break }
            "MB" { 1MB ; break }
            "GB" { 1GB ; break }
            "TB" { 1TB ; break }

            Default {
                # default to gb
                1GB
            }
        }

        $v = $Bytes / $Size
        if($NoRounding -eq $false) {
            $v = [math]::Round($v, $DecimalPlaces)
        }

        return $v
    }
}
