# Publish: win-x64
. $PSScriptRoot\publish.ps1 -target ToyboxImageConverter/ToyboxImageConverter.csproj -publishprofile x64.pubxml

# Publish: win-arm64
. $PSScriptRoot\publish.ps1 -target ToyboxImageConverter/ToyboxImageConverter.csproj -publishprofile arm64.pubxml