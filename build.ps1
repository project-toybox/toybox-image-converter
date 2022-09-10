#Requires -RunAsAdministrator

write-host "----------------------------------------"
write-host "Toybox Image Conversion Server Builder"
write-host "----------------------------------------"

try
{
    # Backup vars.
    $GOOS_OLD = $env:GOOS
    $GOARCH_OLD = $env:GOARCH

    # Build for x86.
    $env:GOOS = 'windows'
    $env:GOARCH = '386'
    go build -o ./dist/x86/tbics.exe ./src/main.go 

    # Build for x64.
    $env:GOOS = 'windows'
    $env:GOARCH = 'amd64'
    go build -o ./dist/x64/tbics.exe ./src/main.go 

    # Done.
    $env:GOOS = $GOOS_OLD
    $env:GOARCH = $GOARCH_OLD
    write-host "Build completed successfully." -ForegroundColor green
}
catch
{
    write-host $_.Exception
    write-host "Build failed." -ForegroundColor red
}