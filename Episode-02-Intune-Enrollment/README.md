# Episode 2 - Windows 11 Entra Join & Intune Enrollment

In Episode 2 of the TayStack Lab, we created our first Windows 11
virtual machine using Hyper-V.

The device was joined to Microsoft Entra ID and enrolled into
Microsoft Intune.

## Troubleshooting

During the build, LAB-PC01 successfully joined Microsoft Entra ID
but initially failed to enrol into Microsoft Intune.

The MDM user scope was found to be set to **None**.

After changing the MDM user scope to **All** and allowing the
configuration to propagate, the MDM discovery URLs became available
on the device.

The device still required the Windows automatic MDM enrollment
process to be triggered before enrollment completed successfully.

## Scripts

### Check-IntuneEnrollment.ps1

Checks:

- Microsoft Entra join status
- Device authentication status
- MDM discovery URL
- MDM enrollment registry entries
- EnterpriseMgmt scheduled tasks
- Microsoft Intune MDM certificates
- Recent MDM enrollment warnings and errors

### Trigger-MDMEnrollment.ps1

Triggers the built-in Windows automatic MDM enrollment process using:

deviceenroller.exe /c /AutoEnrollMDM
