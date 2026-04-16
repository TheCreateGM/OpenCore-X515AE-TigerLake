# Post-Install Guide - ASUS VivoBook X515AE

## Step 1: Generate SMBIOS (CRITICAL)
Never use default empty values!

1. Download GenSMBIOS:
   ```bash
   git clone https://github.com/corpnewt/GenSMBIOS.git
   cd GenSMBIOS
   chmod +x GenSMBIOS.command
   ```

2. Run GenSMBIOS:
   ```bash
   ./GenSMBIOS.command
   ```

3. Select option:
   - `1` = Install MacSerial
   - `3` = Generate SMBIOS
   - SMBIOS Type: `MacBookAir9,1`

4. Copy generated values into `config.plist`:
   ```
   PlatformInfo > Generic:
   - MLB
   - SystemSerialNumber
   - SystemUUID
   - ROM (use 112233445566)
   ```

## Step 2: USB Mapping

1. Download USBToolBox:
   ```bash
   curl -L https://github.com/USBToolBox/tool/releases/download/v1.1.0/UTBMap.zip -o utb.zip && unzip utb.zip
   ```

2. Run in Windows (recommended) or macOS:
   - Click "Discover Ports"
   - Plug USB 2.0 and 3.0 devices into every port
   - Map maximum 15 ports
   - Export UTBMap.kext

3. Replace placeholder kext:
   ```bash
   rm -rf EFI/OC/Kexts/UTBMap.kext
   cp -r UTBMap.kext EFI/OC/Kexts/
   ```

## Step 3: Post-Install Commands

Run these in Terminal after first boot:

```bash
# Disable hibernation (causes issues on laptops)
sudo pmset -a hibernatemode 0
sudo pmset -a standby 0
sudo pmset -a autopoweroff 0
sudo pmset -a sleep 10

# Disable Gatekeeper
sudo spctl --master-disable

# Allow kexts
sudo kextcache -i /
```

## Step 4: Audio Testing

Test layout IDs if audio doesn't work:

| Layout ID | Boot Arg | Notes |
|-----------|----------|-------|
| 21 | `alcid=21` | Default |
| 11 | `alcid=11` | Most common for ALC256 |
| 13 | `alcid=13` | Alternative |
| 66 | `alcid=66` | ASUS specific |

Change in `config.plist > NVRAM > boot-args`

## Step 5: GPU Optimizations

For better framebuffer performance:
1. Remove `-igfxvesa` from boot args after installation
2. Try adding `-igfxfw=2`
3. Ensure DVMT is set to 64MB+ in BIOS

## Step 6: CPU Power Management

1. Generate custom CPUFriendDataProvider:
   ```bash
   # Run CPUFriendFriend
   curl -L https://github.com/corpnewt/CPUFriendFriend/archive/refs/heads/master.zip -o cpuf.zip
   unzip cpuf.zip && cd CPUFriendFriend-master
   chmod +x CPUFriendFriend.command
   ./CPUFriendFriend.command
   ```

2. Select:
   - `0x0A` = i5-1135G7
   - Performance mode: `2` = Balanced
   - Generate kext and replace placeholder

## Troubleshooting

### Common Issues:

1. **No Touchpad**:
   - Verify VoodooI2C kexts are loaded
   - Check SSDT-GPIO is present
   - Enable "I2C Touchpad" in BIOS

2. **No Wi-Fi**:
   - Use correct AirportItlwm version for your macOS
   - Try `itlwm.kext` + Heliport app instead

3. **Sleep Issues**:
   - Check for wake reasons: `pmset -g log | grep -i wake`
   - Disable USB wake: `sudo pmset -a womp 0`
   - Disable wake on network access in System Preferences

4. **Black Screen on Boot**:
   - Add `-igfxvesa` back to boot args
   - Check DVMT pre-allocation value

## Verification Checklist

✅ All kexts loaded: `kextstat | grep -E "Lilu|VirtualSMC|WhateverGreen|AppleALC|Voodoo"`
✅ GPU framebuffer: Check About This Mac
✅ Audio working: Test speakers + headphone jack
✅ Wi-Fi connected
✅ Touchpad gestures working
✅ Battery percentage showing
✅ Sleep/wake cycle working
✅ All USB ports detected

## Final Notes

- **Backup your EFI** before making changes
- Use `debug=0x100 keepsyms=1` for troubleshooting kernel panics
- Remove `-v` (verbose) once everything is working
- Update kexts periodically from official sources
