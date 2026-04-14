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

## Required Files

### SSDT Files (Place in EFI/OC/ACPI/)

Download pre-compiled SSDTs from: https://github.com/acidanthera/OpenCoreACPI

Required SSDTs:
- `SSDT-PLUG.aml` - CPU power management
- `SSDT-EC-USBX.aml` - Embedded Controller fix
- `SSDT-AWAC.aml` - RTC fix
- `SSDT-PNLF.aml` - Backlight control
- `SSDT-XOSI.aml` - OS compatibility
- `SSDT-SBUS-MCHC.aml` - SBUS fix

### Drivers (Place in EFI/OC/Drivers/)

- `OpenRuntime.efi` - Required
- `HfsPlus.efi` - Required for macOS drives
- `OpenCanopy.efi` - GUI picker (optional)

### Kexts (Place in EFI/OC/Kexts/)

**Core:**
- Lilu.kext
- VirtualSMC.kext + SMCBatteryManager.kext + SMCProcessor.kext
- WhateverGreen.kext
- AppleALC.kext

**Input:**
- VoodooPS2Controller.kext
- VoodooI2C.kext + VoodooI2CHID.kext (for ELAN touchpad)

**Connectivity:**
- AirportItlwm.kext (Intel Wi-Fi AX201)
- IntelBluetoothFirmware.kext
- BlueToolFixup.kext

**USB:**
- USBToolBox.kext
- UTBMap.kext (after mapping)

**Power:**
- CPUFriend.kext + CPUFriendDataProvider.kext
- NVMeFix.kext

**ASUS:**
- AsusSMC.kexp (for WMI hotkeys)
- BrightnessKeys.kext
- ECEnabler.kext

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

1. Copy EFI folder to ESP partition
2. Generate SMBIOS serials using GenSMBIOS
3. Obtain SSDT files from OpenCoreACPI repo
4. Download latest kexts from:
   - https://github.com/acidanthera/Lilu
   - https://github.com/acidanthera/VirtualSMC
   - https://github.com/acidanthera/WhateverGreen
   - https://github.com/acidanthera/AppleALC
   - https://github.com/acidanthera/AirportItlwm
   - https://github.com/OpenIntelWireless
5. Download drivers from OpenCore releases
6. Test boot with verbose mode
7. Adjust audio layout if needed
8. Map USB ports after installation

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