# ASUS VivoBook X515AE - Hardware Compatibility Status

## ✅ Working
| Component | Status | Notes |
|-----------|--------|-------|
| **CPU Power Management** | ✅ Full | AppleIntelCPUPowerManagement works |
| **Keyboard** | ✅ Full | All keys + Fn combinations |
| **Touchpad** | ✅ Full | ELAN I2C with multi-gesture support |
| **Wi-Fi (AX201)** | ✅ Full | AirportItlwm kext |
| **Bluetooth** | ✅ Full | IntelBluetoothFirmware + BlueToolFixup |
| **Audio** | ✅ Full | AppleALC with layout-id 21 |
| **USB Ports** | ✅ Full | Custom mapped with USBToolBox |
| **Battery Status** | ✅ Full | SMCBatteryManager + ECEnabler |
| **Webcam** | ✅ Full | USB UVC |
| **SATA SSD** | ✅ Full | Native AHCI |
| **Backlight Control** | ✅ Full | PNLF patch + BrightnessKeys |
| **Sleep/Wake** | ✅ Good | Works with proper configuration |
| **ASUS WMI Hotkeys** | ✅ Partial | Most Fn keys work via AsusSMC |

## ⚠️ Partially Working / Known Issues
| Component | Status | Notes |
|-----------|--------|-------|
| **Intel Iris Xe iGPU** | ⚠️ Partial | **NO full QE/CI acceleration** |
| | | Framebuffer works, display output OK |
| | | Spoofed as Ice Lake UHD 64EUs |
| | | Limited to 1080p @ 60Hz |
| **NVMe Storage** | ⚠️ Conditional | **MUST disable VMD in BIOS** |
| | | If VMD enabled, NVMe will not be detected |
| **HDMI Output** | ⚠️ Untested | May require additional framebuffer patches |
| **SD Card Reader** | ⚠️ Untested | Requires RealtekCardReader.kext |
| **Thunderbolt** | ❌ Not Working | Unsupported in macOS |

## ❌ Not Working
| Component | Status | Notes |
|-----------|--------|-------|
| **Intel Iris Xe Acceleration** | ❌ No | Tiger Lake iGPU unsupported in macOS |
| **Thunderbolt 4** | ❌ No | No support |
| **Fingerprint Reader** | ❌ No | Elan fingerprint sensor unsupported |
| **Intel Smart Sound** | ❌ No | Tiger Lake audio DSP unsupported |

---

## Important Notes

### GPU Status
- **This is expected behavior**. Tiger Lake (11th Gen) iGPUs are **not natively supported** in any macOS version.
- Framebuffer is working through WhateverGreen spoofing as Ice Lake
- You will see 7MB VRAM or "Display 7MB" in About This Mac - this is normal
- **Do NOT waste time trying to get full acceleration** - it is not possible with public tools

### VMD Controller
- **CRITICAL**: You **MUST disable VMD** in BIOS for NVMe to work
- If you cannot disable VMD:
  - Install macOS on SATA SSD
  - NVMe will not be detected at all

---

## Post-Install Recommendations

1. **Generate your own SMBIOS values**
   - Use GenSMBIOS to generate unique MLB, Serial, UUID, ROM
   - Never use the default empty values

2. **Custom USB Map**
   - Run USBToolBox in Windows/macOS
   - Generate your own UTBMap.kext for your specific ports

3. **Disable Hibernation**
   ```bash
   sudo pmset -a hibernatemode 0
   sudo pmset -a standby 0
   sudo pmset -a autopoweroff 0
   ```

4. **Audio Testing**
   - If layout-id 21 doesn't work, try: 11, 13, 15, 66, 88

---

## Tested macOS Versions
- macOS Sonoma 14.x (Recommended)
- macOS Ventura 13.x
- macOS Monterey 12.x (Not recommended)
