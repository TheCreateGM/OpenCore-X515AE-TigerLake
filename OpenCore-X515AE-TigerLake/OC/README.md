# OpenCore EFI Configuration for ASUS VivoBook X515AE (Tiger Lake)

## System Specifications

- **Model:** ASUS VivoBook X515EA/X515AE
- **CPU:** Intel Core i5-1135G7 (Tiger Lake, 4C/8T)
- **iGPU:** Intel Iris Xe Graphics (TigerLake-LP GT2)
- **RAM:** 36GB DDR4 3200 MHz
- **Storage:** 2TB NVMe + 1TB SATA SSD
- **Wi-Fi:** Intel Wi-Fi 6 AX201
- **Bluetooth:** Intel Bluetooth 9460/9560
- **Touchpad:** ELAN1200

## Downloaded Files (Included)

### SSDT Files (In EFI/OC/ACPI/)
- SSDT-PLUG.aml
- SSDT-EC-USBX.aml
- SSDT-AWAC.aml
- SSDT-PNLF.aml
- SSDT-XOSI.aml
- SSDT-SBUS-MCHC.aml

### Drivers (In EFI/OC/Drivers/)
- OpenRuntime.efi
- HfsPlus.efi
- OpenCanopy.efi
- BOOTx64.efi
- OpenShell.efi

### Core Kexts Downloaded (In EFI/OC/Kexts/)
- Lilu.kext
- VirtualSMC.kext
- SMCBatteryManager.kext
- SMCProcessor.kext
- SMCSuperIO.kext
- WhateverGreen.kext
- AppleALC.kext
- AppleALCU.kext

## Additional Kexts to Download Manually

Download these from their GitHub repos and place in EFI/OC/Kexts/:

**Input (for ELAN1200 touchpad):**
- VoodooPS2Controller.kext: https://github.com/acidanthera/VoodooPS2/releases
- VoodooI2C.kext: https://github.com/acidanthera/VoodooI2C/releases
- VoodooI2CHID.kext: https://github.com/acidanthera/VoodooI2C/releases
- VoodooGPIO.kext, VoodooInput.kext (included in VoodooI2C)

**Connectivity (Intel Wi-Fi AX201):**
- AirportItlwm.kext: https://github.com/OpenIntelWireless/itlwm/releases
- IntelBluetoothFirmware.kext: https://github.com/OpenIntelWireless/IntelBluetoothFirmware/releases
- BlueToolFixup.kext: https://github.com/acidanthera/BluS/releases

**Power Management:**
- CPUFriend.kext: https://github.com/acidanthera/CPUFriend/releases
- CPUFriendDataProvider.kext (create for i5-1135G7)

**Additional Fixes:**
- NVMeFix.kext: https://github.com/acidanthera/NVMeFix/releases
- BrightnessKeys.kext: https://github.com/acidanthera/BrightnessKeys/releases
- ECEnabler.kext: https://github.com/acidanthera/ECEnabler/releases
- AsusSMC.kext: https://github.com/hackintosh-stuff/AsusSMC/releases

**USB Mapping:**
- USBToolBox.kext: https://github.com/USBToolBox/tool/releases

## SMBIOS Configuration

In `PlatformInfo > Generic`, set:
- **SystemProductName:** MacBookPro17,1
- Generate unique serials using GenSMBIOS

## Boot Arguments

```
-v keepsyms=1 debug=0x100 alcid=66
```

- `-v` - Verbose boot (remove after stable)
- `alcid=66` - Audio layout ID (may need adjustment)

## DeviceProperties

### iGPU (PciRoot(0x0)/Pci(0x2,0x0))

Uses ICLLP framebuffer compatible with Iris Xe:
- `AAPL,ig-platform-id`: 0000528A (byte-swapped: 8A520000)
- Various patches for Tiger Lake compatibility

### Audio (PciRoot(0x0)/Pci(0x1F,0x3))

- `layout-id`: 66 (adjust for your codec)

## Known Issues & Limitations

### May Not Work
- **HDMI/DP External Output** - Requires eGPU or not supported
- **Full Iris Xe Acceleration** - May work at reduced capabilities
- **DRM** - May have issues with Apple TV content

### Requires Testing
- Audio layout ID (try: 11, 15, 21, 66, 88)
- USB port mapping
- Sleep/wake functionality

## BIOS Settings Required

1. **Disable:** Secure Boot
2. **Disable:** Fast Boot  
3. **Enable:** AHCI mode for SATA
4. **Disable:** CFG Lock (or patch with CFGUnlock)
5. **Set:** DVMT Pre-Alloc to 64MB or 128MB
6. **Enable:** XHCI Hand-off
7. **Enable:** EHCI/XHCI Modifiable

## Installation Steps

1. Download remaining kexts listed above
2. Copy all kexts to EFI/OC/Kexts/
3. Copy EFI folder to ESP partition
4. Generate SMBIOS serials using GenSMBIOS
5. Test boot with verbose mode
6. Adjust audio layout if needed
7. Map USB ports after installation

## Post-Installation

1. Use USBToolBox to map USB ports
2. Replace USBInjectAll with UTBMap.kext
3. Test sleep/wake
4. Fix brightness keys if needed
5. Test all USB ports
6. Verify graphics acceleration

## Credits

- Dortania OpenCore Install Guide
- Reference repos: Bhavinjain260/Asus-Vivobook15-X515JA-Opencore
- itsmaclol/asusx515j-hackintosh
- acidanthera for all kexts