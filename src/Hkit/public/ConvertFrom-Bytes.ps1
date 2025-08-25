function ConvertFrom-Bytes {
    [CmdletBinding(DefaultParameterSetName = 'GB')]
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
        $Size = $null
        switch($PSCmdlet.ParameterSetName){
            "KB" { $Size = 1KB ; break }
            "MB" { $Size = 1MB ; break }
            "GB" { $Size = 1GB ; break }
            "TB" { $Size = 1TB ; break }

            Default {
                # default to gb
                $Size = 1GB
            }
        }

        $v = $Bytes / $Size
        if($NoRounding -eq $false) {
            $v = [math]::Round($v, $DecimalPlaces)
        }

        return $v
    }
}
