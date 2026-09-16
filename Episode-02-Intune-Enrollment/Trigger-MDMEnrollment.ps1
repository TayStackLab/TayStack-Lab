<#
.SYNOPSIS
    Triggers Windows automatic MDM enrollment.

.DESCRIPTION
    Runs the built-in Windows Device Enroller to trigger automatic
    MDM enrollment.

    Run from an elevated PowerShell session.

    Used in TayStack - Episode 2.

.NOTES
    TayStack
    Build • Learn • Automate • Evolve

    Break it in the lab, not in production.
#>

Write-Host "Triggering automatic MDM enrollment..." -ForegroundColor Cyan

& "$env:SystemRoot\System32\deviceenroller.exe" /c /AutoEnrollMDM

Write-Host "MDM enrollment trigger completed." -ForegroundColor Green
