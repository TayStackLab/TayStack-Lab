Write-Host "Local User Accounts" -ForegroundColor Cyan
Get-LocalUser |
    Select-Object Name, Enabled, PasswordLastSet

Write-Host "`nLocal Administrators" -ForegroundColor Cyan
Get-LocalGroupMember -Group "Administrators" |
    Select-Object Name, ObjectClass, PrincipalSource
