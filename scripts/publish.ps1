# --------------------------------------------------
# Toybox .NET Publishing Assistant
# Copyright (c) 2022 handbros and Toybox Contributors all rights reserved.
# --------------------------------------------------

#Requires -Version 7

[CmdletBinding(PositionalBinding = $false)]
Param(
    [string][Alias('v')]$verbosity = "minimal",
    [string][Alias('t')]$target = "",
	[string][Alias('p')]$publishprofile = "",
	[string]$productname = "Unknown Product",
	[string]$productversion = "1.0.0.0",
	[string]$filedesc = "Unknown File Description",
	[string]$fileversion = "1.0.0.0",
	[string]$company = "Unknown Corporation",
	[string]$copyright = "Unknown Copyright",
	[Parameter(ValueFromRemainingArguments = $true)][String[]]$properties,
    [switch] $nologo,
    [switch] $help
)

$Script:BuildPath = ""

function Invoke-ExitWithExitCode([int] $exitCode) {
    if ($ci -and $prepareMachine) {
        Stop-Processes
    }

    exit $exitCode
}

function Invoke-Help {
    Write-Host "Common settings:"
	Write-Host "  -verbosity <value>         Msbuild verbosity: q[uiet], m[inimal], n[ormal], d[etailed], and diag[nostic] (short: -v)"
	Write-Host "  -target <value>            Name of a solution or project file to build (short: -s)"
	Write-Host "  -publishprofile <value>    Publish profile to use (short: -p)"
    Write-Host "  -nologo                    Doesn't display the startup banner or the copyright message"
    Write-Host "  -help                      Print help and exit"
    Write-Host ""
	
	Write-Host "Descriptions:"
	Write-Host "  -productname <value>       Product name"
	Write-Host "  -productversion <value>    Product version"
	Write-Host "  -filedesc <value>          File description"
	Write-Host "  -fileversion <value>       File version"
	Write-Host "  -company <value>           Company name"
	Write-Host "  -copyright <value>         Copyright information"
	Write-Host ""

    Write-Host "Actions:"
    Write-Host "  -restore                   Restore dependencies"
    Write-Host "  -build                     Build solution"
    Write-Host ""
}

function Invoke-Hello {
    if ($nologo) {
        return
    }
	
	Write-Host "Toybox .NET Publishing Assistant" -ForegroundColor White
	Write-Host "Copyright (c) 2022-$(Get-Date -UFormat "%Y") handbros and Toybox Contributors all rights reserved." -ForegroundColor White
    Write-Host ""
}

function Initialize-Script {
	# Check the target
	if ([string]::IsNullOrEmpty($target) -eq $True) {
		Write-Host "Please specify a target file(solution or project)." -ForegroundColor Red
		Invoke-ExitWithExitCode 1
	}

    if ((Test-Path "$($PSScriptRoot)\..\src\$($target)") -eq $False) {
        Write-Host "Target $($PSScriptRoot)\..\src\$($target) not found." -ForegroundColor Red
        Invoke-ExitWithExitCode 1
    }

    $Script:TargetPath = (Resolve-Path -Path "$($PSScriptRoot)\..\src\$($target)").ToString()
	
	# Check the publish profile
	if ([string]::IsNullOrEmpty($publishprofile) -eq $True) {
		Write-Host "Please specify a publish profile." -ForegroundColor Red
		Invoke-ExitWithExitCode 1
	}

    if ((Test-Path "$($PSScriptRoot)\publish_profiles\$($publishprofile)") -eq $False) {
        Write-Host "Publish profile $($PSScriptRoot)\publish_profiles\$($publishprofile) not found." -ForegroundColor Red
        Invoke-ExitWithExitCode 1
    }
	
	$Script:ProfilePath = (Resolve-Path -Path "$($PSScriptRoot)\publish_profiles\$($publishprofile)").ToString()
}

function Invoke-Publish {
    dotnet publish $Script:TargetPath -p:PublishProfileFullPath=$Script:ProfilePath -p:Product=$productname -p:Version=$productversion -p:AssemblyTitle=$filedesc -p:AssemblyVersion=$fileversion -p:Company=$company -p:Copyright=$copyright $properties --verbosity $verbosity --no-restore --nologo

    if ($lastExitCode -ne 0) {
        Write-Host "Publishing failed." -ForegroundColor Red
        Invoke-ExitWithExitCode $LastExitCode
    }
}


if ($help) {
    Invoke-Help

    exit 0
}

[timespan]$execTime = Measure-Command {
    Invoke-Hello | Out-Default
    Initialize-Script | Out-Default
    Invoke-Publish | Out-Default
}

Write-Host "Finished in " -NoNewline
Write-Host "$($execTime.Minutes) min, $($execTime.Seconds) sec, $($execTime.Milliseconds) ms." -ForegroundColor Cyan

Write-Host "Finished at " -NoNewline
Write-Host "$(Get-Date -UFormat "%Y. %m. %d. %R")." -ForegroundColor Cyan