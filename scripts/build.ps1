# --------------------------------------------------
# Toybox .NET Builder 
# Copyright (c) 2022 handbros and Toybox Contributors all rights reserved.
# --------------------------------------------------

#Requires -Version 7

[CmdletBinding(PositionalBinding = $false)]
Param(
    [string][Alias('v')]$verbosity = "minimal",
    [string][Alias('t')]$target = "",
	[Parameter(ValueFromRemainingArguments = $true)][String[]]$properties,
    [switch] $restore,
    [switch] $build,
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
	Write-Host "  -verbosity <value>     Msbuild verbosity: q[uiet], m[inimal], n[ormal], d[etailed], and diag[nostic] (short: -v)"
	Write-Host "  -target <value>        Name of a solution or project file to build (short: -s)"
    Write-Host "  -nologo                Doesn't display the startup banner or the copyright message"
    Write-Host "  -help                  Print help and exit"
    Write-Host ""

    Write-Host "Actions:"
    Write-Host "  -restore               Restore dependencies"
    Write-Host "  -build                 Build solution"
    Write-Host ""
}

function Invoke-Hello {
    if ($nologo) {
        return
    }
	
	Write-Host "Toybox .NET Builder" -ForegroundColor White
	Write-Host "Copyright (c) 2022-$(Get-Date -UFormat "%Y") handbros and Toybox Contributors all rights reserved." -ForegroundColor White
    Write-Host ""
}

function Initialize-Script {
	if ([string]::IsNullOrEmpty($target) -eq $True) {
		Write-Host "Please specify a target file(solution or project)." -ForegroundColor Red
		Invoke-ExitWithExitCode 1
	}

    if ((Test-Path "$($PSScriptRoot)\..\src\$($target)") -eq $False) {
        Write-Host "Target $($PSScriptRoot)\..\src\$($target) not found." -ForegroundColor Red
        Invoke-ExitWithExitCode 1
    }

    $Script:BuildPath = (Resolve-Path -Path "$($PSScriptRoot)\..\src\$($target)").ToString()
}

function Invoke-Params {
	$TextInfo = (Get-Culture).TextInfo
	
	Write-Host " * Verbosity:  " -NoNewline
    Write-Host "$($TextInfo.ToTitleCase($verbosity))" -ForegroundColor Cyan
    Write-Host " * Target:     " -NoNewline
    Write-Host "$target" -ForegroundColor Cyan
	Write-Host " * Properties: " -NoNewline
    Write-Host "$([string]::IsNullOrEmpty($properties) -eq $True ? 'null' : $properties)" -ForegroundColor Cyan
    Write-Host ""
}

function Invoke-Restore {
    if (-not $restore) {
        return
    }

    dotnet restore $Script:BuildPath --verbosity $verbosity

    if ($lastExitCode -ne 0) {
        Write-Host "Restore failed." -ForegroundColor Red

        Invoke-ExitWithExitCode $LastExitCode
    }
}

function Invoke-Build {
    if (-not $build) {
        return
    }

    dotnet build $Script:BuildPath $properties --verbosity $verbosity --no-restore --nologo

    if ($lastExitCode -ne 0) {
        Write-Host "Build failed." -ForegroundColor Red
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
	Invoke-Params | Out-Default
    Invoke-Restore | Out-Default
    Invoke-Build | Out-Default
}

Write-Host "Finished in " -NoNewline
Write-Host "$($execTime.Minutes) min, $($execTime.Seconds) sec, $($execTime.Milliseconds) ms." -ForegroundColor Cyan

Write-Host "Finished at " -NoNewline
Write-Host "$(Get-Date -UFormat "%Y. %m. %d. %R")." -ForegroundColor Cyan