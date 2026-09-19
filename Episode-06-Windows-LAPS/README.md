# Episode 6 - Windows LAPS with Microsoft Intune

In Episode 6 of TayStack, we configure Windows Local Administrator Password Solution (LAPS) using Microsoft Intune.

Windows LAPS allows us to automatically manage and rotate the password of a local administrator account on a Windows device and securely back up the password to Microsoft Entra ID.

In this episode, we deploy a Windows LAPS policy to our Windows 11 lab device, LAB-PC01, and configure Automatic Account Management to create and manage a dedicated local administrator account.

We also troubleshoot a couple of issues during the deployment and use PowerShell and the Windows LAPS Operational event log to determine what is happening on the endpoint.

## What We Configure

The Windows LAPS policy is deployed from:

Microsoft Intune  
Endpoint Security  
Account Protection  
Windows LAPS

The lab configuration includes:

- Password backup to Microsoft Entra ID
- Automatic Account Management enabled
- Dedicated local administrator account
- Local administrator account enabled
- Password rotation every 30 days
- Password/passphrase configuration
- Post-authentication actions
- Password retrieval through Microsoft Intune / Entra ID

The dedicated local administrator account used in the lab is:

`TayStack Admin`

## Troubleshooting

During the deployment, Intune initially reported that the LAPS policy had successfully deployed, but the endpoint was unable to process the configuration.

The Windows LAPS Operational event log helped identify the problems.

### Local Administrator Account Not Found

LAPS initially attempted to manage the configured `TayStack Admin` account, but the account did not exist.

The following error was recorded:

`0x80070002`

Automatic Account Management was then enabled in the LAPS policy so Windows LAPS could create and manage the dedicated administrator account automatically.

### Microsoft Entra LAPS Not Enabled

After enabling Automatic Account Management, Windows LAPS attempted to back up the password to Microsoft Entra ID.

The backup failed with:

`0x80070190`

The LAPS Operational event log showed that the Local Administrator Password Solution had not been enabled at the Microsoft Entra tenant level.

Windows LAPS was then enabled in Microsoft Entra ID.

Once enabled, the managed local administrator password could be successfully backed up and accessed through the device in Microsoft Intune.

## PowerShell Tools

The PowerShell scripts included in this folder were used for troubleshooting and verification during the episode.

They are not required to deploy Windows LAPS through Intune.

### Get-LAPSConfiguration.ps1

Displays the Windows LAPS policy currently applied to the endpoint.

This is useful for confirming that the settings configured in Intune have actually reached the Windows device.

### Get-LAPSEvents.ps1

Displays the latest events from the Windows LAPS Operational event log.

The log can also be viewed through:

Event Viewer  
Applications and Services Logs  
Microsoft  
Windows  
LAPS  
Operational

### Get-LocalAdministrators.ps1

Displays the local user accounts and members of the local Administrators group.

This can be used to confirm that the LAPS-managed local administrator account has been created successfully.

### Invoke-LAPSProcessing.ps1

Manually triggers Windows LAPS policy processing.

After running the script, the Windows LAPS Operational event log can be checked to verify whether processing completed successfully.

## Lab Environment

This episode was created using the TayStack Microsoft lab environment.

The device used in the episode:

`LAB-PC01`

The device is Microsoft Entra joined and managed by Microsoft Intune.

## Important

The configuration shown in this repository is intended for demonstration and lab use.

Always review Microsoft documentation and test policies before deploying Windows LAPS or other security configurations into a production environment.

---

**Break it in the lab, not in production.**
