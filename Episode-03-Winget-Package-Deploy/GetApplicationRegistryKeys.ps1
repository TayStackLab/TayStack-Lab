$appname = "7-zip"

$keys = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKCU:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
)

Get-ItemProperty $keys -ErrorAction SilentlyContinue |
Where-Object { $_.DisplayName -match $appname } |
Select-Object `
    PSPath,
    DisplayName,
    DisplayVersion,
    Publisher,
    InstallLocation,
    UninstallString,
    QuietUninstallString |
Format-List

