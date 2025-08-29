function Test-Command {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$Name
    )
    process {
        $command = Get-Command -Name $Name -ErrorAction SilentlyContinue
        return $null -ne $command
    }
}
