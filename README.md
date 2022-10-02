<p align="right">
<img alt="GitHub" src="https://img.shields.io/github/license/project-toybox/toybox-image-conversion-server">
</p>

<p align="center">
    <h1 align="center">
        <img src="https://raw.githubusercontent.com/project-toybox/toybox-assets/main/images/toybox-icon.png" width="50" height="50">
        <p>Toybox Image Conversion Server</p>
    </h1>
    <p align="center">A server application that provides image conversion APIs to Toybox components.<br>Available with IPC and REST API.</p>
    <br>
</p>

## Structure
```
Image Conversion Server
┣━ /api
   ┣━ /cache
   ┣━ /convert
   ┗━ /log
┣━ /error
┗━ /index
```

## Usage
[View the documentation](README.md) for usage information.

## Build
### Requirements
 * __OS__ : Windows 10 or higher version(include server edtions)
 * __Tools__ : [PowerShell(v7 or higher version)](https://github.com/PowerShell/PowerShell), [.NET SDK(v6.0 or higher version)](https://dotnet.microsoft.com/en-us/download)

### Options
The application is built with such options.
 * __Configuration__ : Release
 * __RuntimeIdentifier(RID)__ : win-x86, win-x64
 * __TargetFramework__ : net6.0
 * __SelfContained__ : false
 * __PublishSingleFile__ : false
 * __PublishReadyToRun__ : true
 * __PublishTrimmed__ : false

### Guide
1. Open a PowerShell terminal from the repository root.
2. Run this command with administrator privilege: `./build.ps1`
3. The compiled program will be stored in `./dist/`.

## License
The contents are available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
