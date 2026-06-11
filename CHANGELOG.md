# Change Log

<!-- markdownlint-disable MD024 -->

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog] and this project adheres to [Semantic Versioning](http://semver.org/).

[Unreleased]: https://github.com/hudsonm62/PS-Hkit/compare/v1.1.0...master

## [Unreleased]

## [v1.1.1] - 2026-06-11

### Fixed

- `Split-Path` not working on module install

### Changed

- Release Notes link in manifest to this file.

## [v1.1.0] - 2026-06-11

### Added

- This changelog file.
- Module to PS Gallery with new publishing workflow
- Help blocks for `Find-UninstallKey`, `Write-Console` & `ConvertFrom-Bytes`
- `SuppressMessageAttribute` for `Get-Uptime` & `Write-Console`
    - Removed Global rules for these.
- Added `Assert-WindowsDevice` line to `Get-Uptime` as a fallback before running the WMI Query
- `DEBUG` level to `Write-Console`
- Code Cov uploads via GitHub Actions
- `psakefile.ps1` for better maintainability, and moved some `./scripts` to this.
- Some tests to complete coverage across the board.

### Changed

- Cleaned up various functions
    - `ConvertFrom-Bytes` now returns directly instead of assigning another var
    - `Get-Uptime`
- Justification reason for `ConvertFrom-Bytes` to be clearer.
- `Format-Letter` function in `Get-AvailableDriveLetter` to be more concise.
- Description, License URL & Tags in Module file.
- Updated repository files to my new standards
- Updated and split workflows
- Line endings for all .PS1 files to be LF
    - Provides better compatibility with non-Windows environments.

### Fixed

- Incorrect endpoints for `Get-PublicIP`

[v1.1.0]: https://github.com/hudsonm62/PS-Hkit/releases/tag/v1.1.0

## [v1.0.0] - 2025-12-13

### Added

- Initial repo files
- Initial Module and tests

[v1.0.0]: https://github.com/hudsonm62/PS-Hkit/releases/tag/v1.0.0

<!--TEMPLATE
## [v0.0.0] - YYYY-MM-YY

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security
[Unreleased]: https://github.com/hudsonm62/PS-Hkit/compare/v1.1.0...master
[v1.1.0]: https://github.com/hudsonm62/PS-Hkit/releases/tag/v1.1.0
-->

[Keep a Changelog]: http://keepachangelog.com/

<!-- markdownlint-enable MD024 -->
