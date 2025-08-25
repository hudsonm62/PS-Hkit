<#
.SYNOPSIS
    Repairs file name conflicts by appending a number to the file name.
.DESCRIPTION
    Repairs file name conflicts by appending a number to the file name, similar to browsers downloading files with the same name

    i.e. "File (1).txt" if "File.txt" already exists, or keeps "File.txt" if it doesn't.

.EXAMPLE
    # Ensures unique name for file download
    Invoke-RestMethod -Uri "download.link" -OutFile (Repair-NameConflict ".\file.txt")
#>
function Repair-NameConflict {
param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$Path
    )
    process {
        $NewPath = $Path.Clone()
        if(Test-Path $Path){
            $i = 0;
            $item = Get-Item $Path
            while(Test-Path $NewPath){
                $i += 1;
                $NewPath = Join-Path $item.DirectoryName ($item.BaseName + " ($i)" + $item.Extension)
            }
        }
        return $NewPath
    }
}
