#Requires -RunAsAdministrator

write-host "----------------------------------------"
write-host "Toybox Image Conversion Server Builder"
write-host "----------------------------------------"

try
{
    $oldLocation = Get-Location

    $fullPathOfCurrentScript = $MyInvocation.MyCommand.Definition # Full path of the script file.
    $fileNameOfCurrentScript = $MyInvocation.MyCommand.Name # Name of the script file.
    $currentPath = $fullPathOfCurrentScript.Replace($fileNameOfCurrentScript, "") # Current executing path.
    $srcPath = Join-Path $currentPath "src"

    # CURRENT PATH
    $currentPathText = [String]::Format(" * Current Path : $currentPath");
    write-host $currentPathText -ForegroundColor blue

    # SRC PATH
    $srcPathText = [String]::Format(" * Src Path : $srcPath");
    write-host $srcPathText -ForegroundColor blue

    # TARGET PLATFORM
    write-host " * Target OS : Windows" -ForegroundColor blue
    write-host " * Target Architecture : x86, x64" -ForegroundColor blue

    Set-Location $srcPath

    # ----------------------------------------------------------------------

    # Backup vars.
    $GOOS_OLD = $env:GOOS
    $GOARCH_OLD = $env:GOARCH

    # Build for x86.
    $env:GOOS = 'windows'
    $env:GOARCH = '386'
    go build -o ../dist/x86/ics.exe ./main.go 

    # Build for x64.
    $env:GOOS = 'windows'
    $env:GOARCH = 'amd64'
    go build -o ../dist/x64/ics.exe ./main.go  

    # ----------------------------------------------------------------------

    # Done.
    Set-Location $oldLocation

    $env:GOOS = $GOOS_OLD
    $env:GOARCH = $GOARCH_OLD
    write-host " * Build completed." -ForegroundColor green
}
catch
{
    write-host $_.Exception
    write-host " * Build failed." -ForegroundColor red
}