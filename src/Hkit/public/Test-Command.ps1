function Test-Command {
    param (
        [string]$CommandName
    )
    $command = Get-Command -Name $CommandName -ErrorAction SilentlyContinue
    return $null -ne $command
}
