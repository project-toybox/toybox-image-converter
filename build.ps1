#Requires -RunAsAdministrator

write-host " _____         _               ___ ___ ___ `n|_   _|__ _  _| |__  _____ __ |_ _/ __/ __|`n  | |/ _ \ || | '_ \/ _ \ \ /  | | (__\__ \`n  |_|\___/\_, |_.__/\___/_\_\ |___\___|___/`n	  |__/                             "
write-host "Toybox Image Conversion Server Builder"
write-host "Copyright (c) 2022 Toybox Contributors."

try
{
	# ----------------------------------------------------------------------
	# Print Paths
    # ----------------------------------------------------------------------
	write-host
	write-host "----------------------------------------"
    write-host " # Paths"
    write-host "----------------------------------------"
	
	# PATHS
    $fullPathOfCurrentScript = $MyInvocation.MyCommand.Definition # Full path of the script file.
    $fileNameOfCurrentScript = $MyInvocation.MyCommand.Name # Name of the script file.
	
    $repositoryPath = $fullPathOfCurrentScript.Replace($fileNameOfCurrentScript, "") # Current executing path.
	$srcPath = Join-Path $repositoryPath "src\"
	$projectPath = Join-Path $repositoryPath "src\ToyboxICS\ToyboxICS.csproj"
	$versionPath = Join-Path $repositoryPath "VERSION"
	
	$x86BinaryPath = Join-Path $repositoryPath "src\ToyboxICS\bin\publish\x86\*"
	$x64BinaryPath = Join-Path $repositoryPath "src\ToyboxICS\bin\publish\x64\*"
	
	$distPath = Join-Path $repositoryPath "dist\"
	$x86DistPath = Join-Path $distPath "toybox-ics-win-x86.zip"
	$x64DistPath = Join-Path $distPath "toybox-ics-win-x64.zip"

    # REPO PATH
    $repositoryPathText = [String]::Format(" * Repository Path : $repositoryPath");
    write-host $repositoryPathText
	
	# SRC PATH
    $srcPathText = [String]::Format(" * SRC Path : $srcPath");
    write-host $srcPathText
	
	# PROJECT PATH
    $projectPathText = [String]::Format(" * Project Path : $projectPath");
    write-host $projectPathText
	
	# BIN(x86) PATH
    $x86BinaryPathText = [String]::Format(" * Binary(x86) Path : $x86BinaryPath");
    write-host $x86BinaryPathText -ForegroundColor blue
		
	# BIN(x64) PATH
    $x64BinaryPathText = [String]::Format(" * Binary(x64) Path : $x64BinaryPath");
    write-host $x64BinaryPathText -ForegroundColor blue
	
    # DIST PATH
    $distPathText = [String]::Format(" * Dist Path : $distPath");
    write-host $distPathText -ForegroundColor blue
	
	$oldLocation = Get-Location
	
	
	
	# ----------------------------------------------------------------------
	# Metadata
	# ----------------------------------------------------------------------
	
	write-host
	write-host "----------------------------------------"
    write-host " # Metadata"
    write-host "----------------------------------------"
	
	$product = "Toybox"
	$productText = [String]::Format(" * Product : $product");
    write-host $productText
	
	$assemblyDesc = "Toybox Image Conversion Server"
	$assemblyDescText = [String]::Format(" * Assembly Description : $assemblyDesc");
    write-host $assemblyDescText
	
	$assemblyVer = Get-Content $versionPath
	$assemblyVerText = [String]::Format(" * Assembly Version : $assemblyVer");
    write-host $assemblyVerText
	
	$company = "Toybox Contributors"
	$companyText = [String]::Format(" * Assembly Description : $company");
    write-host $companyText
	
	$copyright = "Copyright (c) 2022 Toybox Contributors."
	$copyrightText = [String]::Format(" * Copyright : $copyright");
    write-host $copyrightText
	
	
	
	# ----------------------------------------------------------------------
	# Print Build Options
	# ----------------------------------------------------------------------
	
	write-host
	write-host "----------------------------------------"
    write-host " # Build options"
    write-host "----------------------------------------"

    # OPTIONS
    write-host " * Configuration : Release" -ForegroundColor blue
    write-host " * Runtime Identifier : win-x86, win-x64" -ForegroundColor blue
	write-host " * Target Framework : net6.0" -ForegroundColor blue
	write-host " * Self Contained : true"
	write-host " * Publish Single File : false"
	write-host " * Publish Ready to Run : true"
	write-host " * Publish Trimmed : false"
	
	
	
	# ----------------------------------------------------------------------
	# Task
    # ----------------------------------------------------------------------
	
    write-host
	write-host "----------------------------------------"
    write-host " # Task"
    write-host "----------------------------------------"
	
	# Change work directory.
	$chdirText = [String]::Format(" * Change work directory to '$srcPath'.");
	write-host $chdirText
	Set-Location $srcPath
	
	# Build a win-x86 application.
	write-host " * Build an application(win-x86)"
	dotnet publish $projectPath -v m -c Release -p:PublishProfile=x86 -p:Product=$product -p:AssemblyTitle=$assemblyDesc -p:AssemblyVersion=$assemblyVer -p:Company=$company -p:Copyright=$copyright 
	
	# Build a win-x64 application.
	write-host " * Build an application(win-x64)"
	dotnet publish $projectPath -v m -c Release -p:PublishProfile=x64 -p:Product=$product -p:AssemblyTitle=$assemblyDesc -p:AssemblyVersion=$assemblyVer -p:Company=$company -p:Copyright=$copyright 
	
	# Compress files to distribute.
	write-host " * Compress and copy files"
	
	if (Test-Path -Path $distPath) {
	} else {
		New-Item $distPath -itemType Directory
	}
	
	Compress-Archive -Path $x86BinaryPath -DestinationPath $x86DistPath -Force
    Compress-Archive -Path $x64BinaryPath -DestinationPath $x64DistPath -Force


	# ----------------------------------------------------------------------
	# Result
    # ----------------------------------------------------------------------
	
	write-host
	write-host "----------------------------------------"
    write-host " # Result"
    write-host "----------------------------------------"
	
    Set-Location $oldLocation
	
    write-host " * Build completed." -ForegroundColor green
}
catch
{
	# ----------------------------------------------------------------------
	# Result
    # ----------------------------------------------------------------------
	write-host
	write-host "----------------------------------------"
    write-host " # Result"
    write-host "----------------------------------------"
	
	Set-Location $oldLocation
	
    write-host " * Build failed." -ForegroundColor red
	write-host $_.Exception -ForegroundColor red
}