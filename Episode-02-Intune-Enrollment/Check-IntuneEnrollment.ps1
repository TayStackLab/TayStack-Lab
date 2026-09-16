<#
.SYNOPSIS
    Checks the Microsoft Entra ID and Intune MDM enrollment state of a Windows device.

.DESCRIPTION
    Displays the Entra join state, MDM enrollment registry entries,
    EnterpriseMgmt scheduled tasks, Intune MDM certificates and recent
    MDM enrollment warnings/errors.

    Used in TayStack - Episode 2.

.NOTES
    TayStack
    Build • Learn • Automate • Evolve

    Break it in the lab, not in production.
#>

Write-Host "`n=== ENTRA STATE ===" -ForegroundColor Cyan

dsregcmd /status |
    Select-String "AzureAdJoined|DeviceAuthStatus|DeviceId|TenantId|MdmUrl"


Write-Host "`n=== MDM ENROLLMENTS ===" -ForegroundColor Cyan

Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Enrollments" -ErrorAction SilentlyContinue |
ForEach-Object {

    $Enrollment = Get-ItemProperty $_.PSPath -ErrorAction SilentlyContinue

    if ($Enrollment.ProviderID -or
        $Enrollment.EnrollmentType -or
        $Enrollment.UPN) {

        [PSCustomObject]@{
            EnrollmentID   = $_.PSChildName
            ProviderID     = $Enrollment.ProviderID
            UPN            = $Enrollment.UPN
            EnrollmentType = $Enrollment.EnrollmentType
        }
    }

} | Format-Table -AutoSize


Write-Host "`n=== ENTERPRISEMGMT TASKS ===" -ForegroundColor Cyan

Get-ScheduledTask -ErrorAction SilentlyContinue |
Where-Object {
    $_.TaskPath -like "\Microsoft\Windows\EnterpriseMgmt\*"
} |
Select-Object TaskName, State, TaskPath |
Format-Table -AutoSize


Write-Host "`n=== INTUNE MDM CERTIFICATES ===" -ForegroundColor Cyan

Get-ChildItem Cert:\LocalMachine\My |
Where-Object {
    $_.Issuer -like "*Intune*" -or
    $_.Subject -like "*Intune*"
} |
Select-Object Subject, Issuer, Thumbprint, NotBefore, NotAfter |
Format-Table -AutoSize


Write-Host "`n=== MDM WARNINGS / ERRORS ===" -ForegroundColor Cyan

Get-WinEvent -FilterHashtable @{
    LogName   = "Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Admin"
    Level     = 2,3
    StartTime = (Get-Date).AddDays(-2)
} -ErrorAction SilentlyContinue |
Select-Object TimeCreated, Id, LevelDisplayName, Message |
Format-List
