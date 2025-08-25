# Hudson's PowerShell Kit

Common set of functions for PowerShell for use in scripts, third-party modules, and other PowerShell tasks.

```powershell
Install-Module Hkit
```

## Windows / Linux / MacOS Compatibility

At the moment, the module will happily import for cross-platform, and should work without any issues. However some functions are Windows specific and will throw an error if ran on non-Windows platforms.

See [`Get-AvailableDriveLetter`](./src/Hkit/public/Get-AvailableDriveLetter.ps1) or [`Find-UninstallKey`](./src/Hkit/public/Find-UninstallKey.ps1) for examples of how we're blocking non-Windows platforms.
