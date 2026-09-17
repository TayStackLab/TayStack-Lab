$SourceFolder     = "winget"
$InstallerName    = "winget.ps1"

$Source           = "C:\Temp\Source\$sourcefolder"
$Destination      = "C:\temp\destination\$SourceFolder"
$IntuneWinAppUtil = "C:\temp\IntuneWinAppUtil.exe"

# Pre-checks
if (-not (Test-Path $IntuneWinAppUtil)) { throw "Missing tool: $IntuneWinAppUtil" }
if (-not (Test-Path $Source))           { throw "Missing source folder: $Source" }


$SetupFileFull = Join-Path $Source $InstallerName
if (-not (Test-Path $SetupFileFull))    { throw "Missing setup file in source: $SetupFileFull" }

New-Item -ItemType Directory -Path $Destination -Force | Out-Null

# IMPORTANT: actually execute the EXE using &
& $IntuneWinAppUtil `
  -c $Source `
  -s $InstallerName `
  -o $Destination `
  -q

# Confirm output
Get-ChildItem $Destination -Filter *.intunewin | Select-Object FullName, Length, LastWriteTime

