function Read-EDID {
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [int[]]$Data
    )
    process {
        # 1. filter out array padding
        # 2. convert to text
        return ($Data | Where-Object { $_ -ne 0 } | ForEach-Object { [char]$_ }) -join ""
    }
}
