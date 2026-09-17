# Episode 3 - Deploy WinGet Applications with Intune

In Episode 3 of the TayStack Lab, we use WinGet to deploy applications through Microsoft Intune.

The goal is to create a reusable PowerShell wrapper that allows different WinGet applications to be deployed through Intune without creating a completely new deployment script for every application.

7-Zip is used as the test application for the episode.

## What We Cover

- Finding applications and package IDs using WinGet
- Creating a reusable PowerShell WinGet wrapper
- Packaging the script as an Intune Win32 application
- Deploying WinGet applications in the SYSTEM context
- Installing applications with machine scope
- Making applications available through Company Portal
- Logging WinGet operations for troubleshooting
- Detecting successful installations
- Uninstalling applications through Company Portal

## WinGet Wrapper

The `Winget.ps1` script included in this folder supports multiple operations including:

- Install or Update
- Uninstall

The application to manage is supplied using its WinGet package ID.

For example, the WinGet package ID used for 7-Zip in this episode is:

7zip.7zip
