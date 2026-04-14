# Hardware-Specific Fixes for ASUS VivoBook X515AE (Tiger Lake)

## Graphics (Iris Xe) - Critical

### Issue
Iris Xe (Tiger Lake) iGPU support is limited in macOS. Unlike Ice Lake, Tiger Lake has different framebuffer requirements.

### Solutions (Try in Order)

**1. Default ICLLP Framebuffer (Recommended)**
```
AAPL,ig-platform-id: 0000528A
device-id: 00004012
```
This uses Ice Lake framebuffer which has the best compatibility.

**2. Enable Various Patches**
```
enable-lspcon-support: YES
framebuffer-patch-enable: YES
enable-dvmt-calc-fix: YES  
enable-cdclk-frequency-fix: YES
force-online: YES
```

**3. If No Acceleration (7MB VRAM, solid dock)**
Try additional boot args:
```
igfxfw=2
```
Or modify framebuffer-stolenmem to smaller value.

### VRAM Check
Run `gfxutil get-displays` or check About This Mac. Should show:
- Correct VRAM (up to 1536MB with framebuffer patches)
- GPU: Intel Iris Xe

## Wi-Fi (Intel AX201)

### Working
- AirportItlwm.kext provides native-like Wi-Fi
- Supports macOS 11+ (Ventura, Sonoma)

### Fixes
1. Ensure correct AirportItlwm version for your macOS
2. Wi-Fi name: `Wi-Fi` (en0)
3. May need to disable/enable after boot

## Bluetooth (Intel 9460/9560)

### Required Kexts
- IntelBluetoothFirmware.kext
- BlueToolFixup.kext
- IntelBTPatcher.kext (sometimes needed)

### Fixes
- Enable in System Preferences
- May need `btlenable=1` boot arg initially

## Audio (Intel HD Audio PCH)

### Layout IDs to Try (ASUS VivoBook common)
- layout-id: 11
- layout-id: 15  
- layout-id: 21
- layout-id: 66
- layout-id: 88

### Boot Arg
```
alcid=66
```

### Testing
1. Test all ports: headphone, microphone, speakers
2. If no sound, try different layout-id
3. Check AppleALC supported codecs

## Touchpad (ELAN1200)

### Solution - VoodooI2C Stack
1. VoodooI2C.kext
2. VoodooI2CHID.kext (for ELAN HID)
3. VoodooGPIO.kext
4. VoodooI2CServices.kext
5. VoodooInput.kext

### Configuration
- Set in BIOS: Enable I2C touchpad
- Works with multi-gestures

### Alternative - VoodooPS2
If I2C fails:
- VoodooPS2Controller.kext with trackpad plugin disabled
- VoodooPS2Trackpad.kext enabled

## Keyboard (PS/2)

### Solution - VoodooPS2Controller
```
VoodooPS2Controller.kext
VoodooPS2Keyboard.kext
```

### Brightness Keys
- BrightnessKeys.kext
- May need kernel patch if not working

## USB Ports

### Mapping Required
1. Run USBToolBox in macOS
2. Create custom UTBMap.kext
3. Replace USBInjectAll

### X515AE Typical Ports
- USB-C (1 port)
- USB-A x3 (typically)
- Disable unused/internal ports in map

## NVMe

### Fixes
1. NVMeFix.kext - Required
2. May need `nvme=0` for compatibility
3. Check in System Profiler

## Battery

### Solution
- SMCBatteryManager.kext
- ECEnabler.kext (for EC access)

### Typical Behavior
- Shows percentage correctly
- Charging indicator works
- May stop at 60-80% (common for some models)

## Webcam

### Status
- USB UVC camera
- Should work OOB with standard drivers

## Card Reader

### If Present
- RealtekCardReader.kext (if supported)
- May not work on all models

## Sleep/Wake

### Common Issues
1. Disable hibernation: `hibernatemode 0`
2. May need USB wake fix
3. Test with `pmset -a standby 0`

### Fixes
Try adding:
```
sudo pmset -a standby 0
sudo pmset -a autopoweroff 0
```

## WMI Keys (ASUS)

### Solution
- AsusSMC.kext
- Handles Fn+key combinations
- Hotkey support

---

## Quick Fix Flowchart

1. **Boot to Installer?**
   - No: Check boot args, SSDTs
   - Yes: Continue

2. **No Graphics?**
   - Check AAPL,ig-platform-id
   - Try igfxfw=2 boot arg

3. **No Audio?**
   - Change alcid= to different layout

4. **No Touchpad?**
   - Use VoodooI2C instead of PS2

5. **No WiFi?**
   - Use AirportItlwm with correct version

6. **No USB?**
   - Map USB ports manually

7. **Sleep Issues?**
   - Disable USB wake
   - Check power management