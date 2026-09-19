Get-BitLockerVolume |
    Select-Object MountPoint, VolumeStatus, ProtectionStatus, EncryptionPercentage, EncryptionMethod

manage-bde -status C:
