<p align="center">
    <h1 align="center">
        <img src="https://raw.githubusercontent.com/project-toybox/toybox-assets/main/images/toybox-icon.png" width="50" height="50">
        <p>Toybox Image Converter</p>
    </h1>
    <p align="center"><b>An image format converter for Toybox</b></p>
    <p align="center">
        <a target="_blank" href="https://github.com/project-toybox/toybox-image-converter/actions"><img alt="GitHub Workflow Status" src="https://img.shields.io/github/workflow/status/project-toybox/toybox-image-converter/Release"></a>
        <a target="_blank" href="https://github.com/project-toybox/toybox-image-converter/releases/latest"><img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/project-toybox/toybox-image-converter"></a>
        <a target="_blank" href="https://github.com/project-toybox/toybox-image-converter/blob/main/LICENSE"><img alt="GitHub" src="https://img.shields.io/github/license/project-toybox/toybox-image-converter"></a>
    </p>
</p>

## Usage
[View the documentation](README.md) for usage information.

## Build
### Requirements
 * __OS__ : Windows 10 or higher version(include server edtions)
 * __Tools__
   * [PowerShell 7](https://github.com/PowerShell/PowerShell)
   * [Visual Studio 2022](https://visualstudio.microsoft.com/)(include 'Desktop development with C++' and '.NET desktop development' workload)
   * [.NET 7 SDK](https://dotnet.microsoft.com/en-us/download)

### Guide
1. Open a PowerShell terminal from `./scripts`.
2. Run the commands below.
```pwsh
Set-ExecutionPolicy Unrestricted
./publish.ps1 -target ToyboxImageConverter/ToyboxImageConverter.csproj -publishProfile (x64|arm64).pubxml -excludeSymbols $(true|false)
```

## License
The contents are freely available under the [GPL-2.0](http://opensource.org/licenses/GPL-2.0).

The licenses of third-party libraries can be found [here](https://github.com/project-toybox/toybox-image-conversion-server/blob/main/docs/THIRD_PARTY_NOTICES.md).
