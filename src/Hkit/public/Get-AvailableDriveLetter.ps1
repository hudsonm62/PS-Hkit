<#
.DESCRIPTION
    Returns a random available drive letter.

.PARAMETER All
    Returns all available drive letters, instead of a random one.

.PARAMETER ExcludedLetters
    Array of letters to exclude from search.
.NOTES
    Only supported on Windows.
#>
function Get-AvailableDriveLetter {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]]$ExcludedLetters,

        [Parameter()]
        [switch]$All
    )

    Assert-WindowsDevice -ErrorAction Stop

    function Format-Letter {
        param ([Parameter(ValueFromPipeline, Mandatory)][string]$Letter)
        process {
            $Letter = $Letter.ToUpper()
            $Letter = $Letter.Replace(' ', '')
            $Letter = $Letter.Replace(':', '')
            return "$Letter`:"
        }
    }

    [string[]]$FormattedExcluded = if($ExcludedLetters){
        $ExcludedLetters | Format-Letter
    }
    $Drives = Get-ChildItem -Path Function:[a-z]: -Name | Where-Object { $FormattedExcluded -notcontains $_ }

    $Available = $Drives | Where-Object { -not (Test-Path $_) }

    if($All){
        return $Available | Sort-Object
    }

    # DEFAULT: Return a random drive letter
    return $Available | Get-Random
}
