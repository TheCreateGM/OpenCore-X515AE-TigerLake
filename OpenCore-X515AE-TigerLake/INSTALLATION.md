# OpenCore Configuration for ASUS VivoBook X515AE (Tiger Lake)

## Quick Start

### 1. Prerequisites
- 16GB+ USB drive
- macOS installer image
- GenSMBIOS (for serials)
- ProperTree (for config editing)

### 2. BIOS Settings (Critical)
See `BIOS-SETTINGS.md`:
- Disable Secure Boot
- Enable AHCI Mode  
- Set DVMT Pre-Alloc to 64MB+
- Disable CFG Lock

### 3. Download Required Files

**From OpenCore Releases:**
- OpenRuntime.efi
- HfsPlus.efi
- OpenCanopy.efi

**From OpenCoreACPI:**
- SSDT-PLUG.aml
- SSDT-EC-USBX.aml
- SSDT-AWAC.aml
- SSDT-PNLF.aml
- SSDT-XOSI.aml
- SSDT-SBUS-MCHC.aml

**From acidanthera's GitHub:**
- Lilu.kext
- VirtualSMC.kext + SMCBatteryManager.kext + SMCProcessor.kext
- WhateverGreen.kext  
- AppleALC.kext

**From OpenIntelWireless:**
- AirportItlwm.kext
- IntelBluetoothFirmware.kext
- BlueToolFixup.kext

**Input Drivers:**
- VoodooPS2Controller.kext
- VoodooI2C.kext + VoodooI2CHID.kext

**Additional:**
- CPUFriend.kext
- CPUFriendDataProvider.kext
- NVMeFix.kext
- BrightnessKeys.kext
- ECEnabler.kext
- AsusSMC.kext
- USBToolBox.kext
- UTBMap.kext

### 4. Copy EFI Structure

```
EFI/
├── BOOT/
│   └── BOOTX64.efi
└── OC/
    ├── config.plist
    ├── ACPI/
    │   ├── SSDT-PLUG.aml
    │   ├── SSDT-EC-USBX.aml
    │   ├── SSDT-AWAC.aml
    │   ├── SSDT-PNLF.aml
    │   ├── SSDT-XOSI.aml
    │   └── SSDT-SBUS-MCHC.aml
    ├── Drivers/
    │   ├── OpenRuntime.efi
    │   ├── HfsPlus.efi
    │   └── OpenCanopy.efi
    ├── Kexts/
    │   └── [all kexts here]
    └── Tools/
        └── OpenShell.efi
```

### 5. Configure PlatformInfo

1. Run GenSMBIOS
2. Select MacBookPro17,1
3. Enter details in config.plist:
   - SystemSerialNumber
   - MLB
   - SystemUUID
   - ROM (Ethernet MAC)

### 6. Boot & Test

1. Boot with USB
2. SelectmacOS installer
3. Wait for verbose output
4. Check for errors

### 7. Post-Installation

1. Install macOS
2. Mount EFI partition
3. Copy EFI to ESP
4. Boot without USB
5. Test functionality

---

## Key Configuration Values

### SMBIOS
- Model: MacBookPro17,1

### Boot Arguments
```
-v keepsyms=1 debug=0x100 alcid=66
```

### iGPU Properties
```
AAPL,ig-platform-id: 0000528A
device-id: 00004012
```

---

## Troubleshooting

### No Boot
- Check EFI in USB
- Verify boot order
- Add -v for verbose

### Kernel Panic
- Check SSDTs
- Verify kexts

### No Graphics
- Try different platform-id
- Add igfxfw=2

### No Audio  
- Change alcid= (try 11, 15, 21, 66, 88)

### No Touchpad
- Use VoodooI2C stack

---

## Documentation Files

- `README.md` - Overview
- `BIOS-SETTINGS.md` - BIOS configuration
- `HARDWARE-FIXES.md` - Hardware-specific fixes
- `TESTING-CHECKLIST.md` - Testing procedures

---

## Support

- Dortania Discord
- r/Hackintosh
- InsanelyMac Forums