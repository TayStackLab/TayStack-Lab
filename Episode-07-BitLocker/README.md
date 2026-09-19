# Episode 7 - BitLocker with Microsoft Intune

In Episode 7 of TayStack, we configure and deploy BitLocker drive encryption using Microsoft Intune.

Following on from Episode 6, where we configured Windows LAPS, we continue securing our Windows 11 lab device, LAB-PC01.

In this episode, we create a BitLocker policy using Endpoint Security in Microsoft Intune, deploy it to LAB-PC01 and verify the configuration directly on the endpoint.

We also run into an issue where Intune reports that the policy has successfully applied, but BitLocker protection remains disabled.

Using PowerShell, manage-bde and the Windows BitLocker event logs, we troubleshoot the deployment and discover that bootable installation media attached to our Hyper-V virtual machine is preventing silent BitLocker encryption.

After removing the installation media and restarting LAB-PC01, BitLocker successfully enables and the recovery information is backed up to Microsoft Intune.

## What We Configure

The BitLocker policy is deployed from:

Microsoft Intune  
Endpoint Security  
Disk Encryption  
BitLocker

The lab configuration includes:

- Require device encryption
- Silent BitLocker encryption
- TPM-based protection
- Used Space Only encryption
- 48-digit recovery password
- Recovery password rotation
- Recovery information backed up to Microsoft Entra ID
- BitLocker recovery information accessible through Microsoft Intune

## Lab Environment

The device used in this episode is:

`LAB-PC01`

LAB-PC01 is a Windows 11 Hyper-V virtual machine that is Microsoft Entra joined and managed by Microsoft Intune.

The virtual machine has a virtual TPM enabled and available to Windows.

## BitLocker Verification

Before deploying the policy, we check the existing BitLocker configuration on LAB-PC01.

The drive initially reports:

- Fully encrypted
- XTS-AES 128 encryption
- BitLocker protection off
- No key protectors

We also verify that the virtual TPM is present and ready before deploying the Intune policy.

After the policy is deployed, Intune reports that the BitLocker policy has successfully applied.

However, checking LAB-PC01 directly shows that BitLocker protection is still disabled.

This demonstrates why it is important to verify the configuration on the endpoint rather than relying only on the policy status reported by Intune.

## Troubleshooting

The Windows BitLocker event log is used to investigate why silent BitLocker encryption is not starting.

The following event is recorded:

`Event ID 853`

The event reports that BitLocker has detected bootable CD or DVD media attached to the computer.

Because LAB-PC01 is a Hyper-V virtual machine, we check the virtual DVD drive and discover that the Windows installation ISO used to originally build the VM is still mounted.

The installation media is removed from the virtual DVD drive and LAB-PC01 is restarted.

After the restart, the Intune BitLocker policy is able to successfully configure BitLocker.

## Successful Deployment

After resolving the issue, BitLocker reports:

- Protection Status: On
- Encryption Method: XTS-AES 128
- TPM key protector
- Numerical Password key protector

The Numerical Password protector is the BitLocker recovery password.

The TPM protector allows BitLocker to unlock the operating system drive during a trusted boot, while the recovery password provides a recovery method if the TPM cannot automatically unlock the drive.

The BitLocker recovery information is then verified through Microsoft Intune.

## Tools Used

The following built-in Windows tools and PowerShell commands are used during the episode:

### Get-BitLockerVolume

Used to check:

- Encryption status
- Protection status
- Encryption percentage
- Encryption method
- Key protectors

### manage-bde

Used to display detailed BitLocker information for the operating system drive.

### Get-Tpm

Used to verify that the Hyper-V virtual TPM is:

- Present
- Ready
- Enabled
- Activated

### reagentc

Used to verify that the Windows Recovery Environment is enabled.

### BitLocker Event Logs

BitLocker troubleshooting information can be found in:

Event Viewer  
Applications and Services Logs  
Microsoft  
Windows  
BitLocker  
BitLocker Management

The event log was particularly useful in this episode for identifying the bootable media that was preventing silent encryption.

## PowerShell Tools

The PowerShell scripts included in this folder can be used to verify and troubleshoot a BitLocker deployment.

They are not required to deploy BitLocker through Microsoft Intune.

The scripts are intended to make it easier to reproduce the verification and troubleshooting demonstrated during the episode.

## Important

The configuration shown in this repository is intended for demonstration and lab use.

BitLocker configuration should be tested before being deployed to production devices.

Always review your organisation's security requirements, recovery key management and existing disk encryption configuration before deploying BitLocker.

---

**Break it in the lab, not in production.**
