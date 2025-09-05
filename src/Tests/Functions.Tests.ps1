[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '', Justification = 'testing suite')] param()

BeforeDiscovery {
    if(-not (Get-Module Hkit -ErrorAction SilentlyContinue)){
        $HkitRoot = Resolve-path (Join-Path -Path "./" -ChildPath "src/Hkit")
        Import-Module $HkitRoot -Force -ErrorAction Stop
    }
}

Describe "ConvertFrom-Bytes" {
    BeforeAll {
        $Bytes = 12345678910
    }
    It "should convert bytes to KB" {
        $result = ConvertFrom-Bytes -Bytes $Bytes -KB
        $result | Should -Be 12056327.06
    }
    It "Should convert bytes to MB" {
        $result = ConvertFrom-Bytes -Bytes $Bytes -MB
        $result | Should -Be 11773.76
    }
    It "should convert bytes to GB" {
        $result = ConvertFrom-Bytes -Bytes $Bytes -GB
        $result | Should -Be 11.5
    }
    It "should convert bytes to TB" {
        $result = ConvertFrom-Bytes -Bytes $Bytes -TB
        $result | Should -Be 0.01
    }

    It "should not round values" {
        $result = ConvertFrom-Bytes -Bytes $Bytes -NoRounding -GB
        [decimal]$result | Should -Be 11.4978094678372
    }
    It "should round to 3 decimal points" {
        $result = ConvertFrom-Bytes -Bytes $Bytes -GB -DecimalPlaces 3
        $result | Should -Be 11.498
    }
}

Describe "Find-UninstallKey" {
    It "should find an uninstall key for a application" {
        $appName = "*"
        $result = Find-UninstallKey -Name $appName
        $result | Should -Not -BeNullOrEmpty
    }
} -Skip:($PSVersionTable.PSVersion.Major -ge 6 -and ($IsLinux -or $IsMacOS))

Describe "Get-AvailableDriveLetter" {
    It "should return an available drive letter" {
        $result = Get-AvailableDriveLetter
        $result | Should -Not -BeNullOrEmpty
    }
    It "should return all available drive letters" {
        $result = Get-AvailableDriveLetter -All
        $result | Should -Not -BeNullOrEmpty
        $result.Count | Should -BeGreaterThan 1
    }
} -Skip:($PSVersionTable.PSVersion.Major -ge 6 -and ($IsLinux -or $IsMacOS))

Describe "Get-CIDRHost" {
    It "should return 254 hosts for a /24 subnet" {
        $result = Get-CIDRHost -Range "192.168.1.0" -Bitmask 24
        $result.Count | Should -Be 254
    }
    It "should return 2 hosts for a /30 subnet" {
        $result = Get-CIDRHost -Range "192.168.1.0" -Bitmask 30
        $result.Count | Should -BeExactly 2
    }
    It "should error for a malformed IP" {
        { Get-CIDRHost -Range "invalid-ip" -Bitmask 24 } | Should -Throw
        { Get-CIDRHost -Range 1.2.3.4.5.6.7.8.9 } | Should -Throw
    }
}

Describe "Get-PublicIP" {
    It "should return a public IP address" {
        $result = Get-PublicIP
        $result | Should -Not -BeNullOrEmpty
    }
}

Describe "Get-Uptime" {
    It "should return the system uptime" {
        $result = Get-Uptime
        $result | Should -Not -BeNullOrEmpty
        $result | Should -BeOfType [TimeSpan]
    }
}

Describe "Get-WindowsDisplayVersion" {
    It "should return the Windows display version" {
        $result = Get-WindowsDisplayVersion
        $result | Should -Not -BeNullOrEmpty
    }
} -Skip:($PSVersionTable.PSVersion.Major -ge 6 -and ($IsLinux -or $IsMacOS))

Describe "Read-EDID" {
    It "should read EDID properly" {
        [uint16[]]$EDID = @(76,81,49,52,52,80,49,74,88,48,49,0,0)
        Read-EDID -Data $EDID | Should -Be "LQ144P1JX01"
    }
}

Describe "Repair-NameConflict" {
    BeforeAll {
        $NewFile = (Join-Path $env:TEMP "UniqueFile.txt")
        $p = (Join-Path $env:TEMP "TestFile.txt")
        New-Item -Path $p -ItemType File -Force | Out-Null
    }
    It "should repair name conflicts" {
        $result = Repair-NameConflict -Path $p
        $result | Should -Be (Join-Path $env:TEMP "TestFile (1).txt")
    }
    It "should not change names if no conflict" {
        $result = Repair-NameConflict -Path $newFile
        $result | Should -Be $newFile
    }
    AfterAll {
        Remove-Item -Path $p -Force
    }
}

Describe "Test-Command" {
    It "should return $true for existing command" {
        $result = Test-Command Write-Host
        $result | Should -Be $true
    }
    It "should not error for non-existing command" {
        $result = { Test-Command commandthatdoesntexist }
        $result | Should -Not -Throw
    }
    It "should return $false for non-existing command" {
        $result = Test-Command commandthatdoesntexist
        $result | Should -Be $false
    }
}
