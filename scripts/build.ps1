# --------------------------------------------------
# Toybox .NET Builder 
# Copyright (c) 2022 handbros and Toybox Contributors all rights reserved.
# --------------------------------------------------

#Requires -Version 7

[CmdletBinding(PositionalBinding = $false)]
Param(
    [string][Alias('c')]$configuration = "Release",
    [string][Alias('v')]$verbosity = "minimal",
    [string][Alias('p')]$platform = "x64",
    [string][Alias('s')]$solution = "",
	[Parameter(ValueFromRemainingArguments = $true)][String[]]$properties,
    [switch][Alias('r')]$restore,
    [switch][Alias('b')]$build,
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
    Write-Host "  -configuration <value>  Build configuration: 'Debug' or 'Release' (short: -c)"
    Write-Host "  -platform <value>       Platform configuration: 'x86', 'x64' or any valid Platform value to pass to msbuild"
    Write-Host "  -verbosity <value>      Msbuild verbosity: q[uiet], m[inimal], n[ormal], d[etailed], and diag[nostic] (short: -v)"
    Write-Host "  -nologo                 Doesn't display the startup banner or the copyright message"
    Write-Host "  -help                   Print help and exit"
    Write-Host ""

    Write-Host "Actions:"
    Write-Host "  -restore                Restore dependencies (short: -r)"
    Write-Host "  -build                  Build solution (short: -b)"
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
	if ([string]::IsNullOrEmpty($solution) -eq $True) {
		Write-Host "Please specify a solution file." -ForegroundColor Red
		Invoke-ExitWithExitCode 1
	}

    if ((Test-Path "$($PSScriptRoot)\..\src\$($solution)") -eq $False) {
        Write-Host "Solution $($PSScriptRoot)\..\src\$($solution) not found." -ForegroundColor Red
        Invoke-ExitWithExitCode 1
    }

    $Script:BuildPath = (Resolve-Path -Path "$($PSScriptRoot)\..\src\$($solution)").ToString()
}

function Invoke-Params {
	$TextInfo = (Get-Culture).TextInfo
	
	Write-Host " * Verbosity:     " -NoNewline
    Write-Host "$($TextInfo.ToTitleCase($verbosity))" -ForegroundColor Cyan
    Write-Host " * Solution:      " -NoNewline
    Write-Host "$($Script:Solution)" -ForegroundColor Cyan
    Write-Host " * Configuration: " -NoNewline
    Write-Host "$($TextInfo.ToTitleCase($configuration))" -ForegroundColor Cyan
    Write-Host " * Platform:      " -NoNewline
    Write-Host "$($TextInfo.ToTitleCase($platform))" -ForegroundColor Cyan
	Write-Host " * Properties:    " -NoNewline
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

    dotnet build $Script:BuildPath --configuration $configuration --verbosity $verbosity --no-restore --nologo $properties

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