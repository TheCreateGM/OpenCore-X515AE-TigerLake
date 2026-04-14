# Testing Checklist - ASUS VivoBook X515AE (Tiger Lake)

## Phase 1: Initial Boot Test

### Must Pass
- [ ] Boot to macOS installer
- [ ] EFI folder loads correctly
- [ ] OpenCore picker appears

### Check Verbose Output (-v boot)
- [ ] No kernel panic on boot
- [ ] Lilu loaded
- [ ] VirtualSMC loaded  
- [ ] WhateverGreen loaded
- [ ] AppleALC loaded

## Phase 2: Graphics

### Test
- [ ] Boot to desktop
- [ ] Check About This Mac > Graphics
- [ ] VRAM shows > 7MB (should show 1536MB)
- [ ] No solid color dock
- [ ] Display renders correctly
- [ ] No graphical glitches

### Expected VRAM
- Without patches: Limited (7MB)
- With patches: Up to 1536MB

## Phase 3: Input Devices

### Keyboard
- [ ] Keyboard works
- [ ] Special keys work (volume, brightness)
- [ ] Fn keys work (with AsusSMC)

### Touchpad
- [ ] Touchpad detected
- [ ] Multi-gestures work
- [ ] Tapping works
- [ ] Scrolling works
- [ ] Drag capability

### Expected: Full VoodooI2C functionality

## Phase 4: Audio

### Test Each Output
- [ ] Speakers play sound
- [ ] Headphone jack works
- [ ] No crackling/popping

### Test Input
- [ ] Microphone works (if present)
- [ ] Headset combo works

### Check System Preferences > Sound

## Phase 5: Storage

### Drives
- [ ] NVMe detected
- [ ] SATA SSD detected
- [ ] Read/write works
- [ ] Both drives mount

### Expected: Full access

## Phase 6: Connectivity

### Wi-Fi (AX201)
- [ ] Wi-Fi menu appears
- [ ] Networks found
- [ ] Can connect
- [ ] Internet works

### Expected: Near-native performance

### Bluetooth
- [ ] Bluetooth enabled
- [ ] Devices found
- [ ] Pairing works
- [ ] File transfer (if supported)

## Phase 7: USB

### Test All Ports
- [ ] USB-C port
- [ ] Each USB-A port
- [ ] Devices mount correctly
- [ ] Power delivery (if supported)

### Expected: All ports functional

## Phase 8: Power Management

### Test
- [ ] Battery shows percentage
- [ ] Charging works
- [ ] Power adapter detected

### Sleep Testing
- [ ] Sleep closes lid
- [ ] Sleep via menu
- [ ] Wake with keyboard
- [ ] Wake with mouse
- [ ] Wake with power button

### Expected: Sleep/wake works

## Phase 9: System Integration

### Test
- [ ] iCloud works
- [ ] App Store works
- [ ] Apple Music works
- [ ] Apple TV app (may have DRM issues)
- [ ] FaceTime (camera test)
- [ ] Messages app

## Phase 10: Performance

### Benchmark
- [ ] Geekbench scores reasonable
- [ ] No stuttering in UI
- [ ] Video playback smooth

---

## Troubleshooting by Symptom

### Black Screen After Boot
1. Add `-v` boot arg
2. Check for iGPU panic
3. Try different framebuffer
4. Add `igfxfw=2`

### No Audio
1. Change alcid= (try 11, 15, 21, 66, 88)
2. Restart after change
3. Check AppleALC supported codecs

### No Wi-Fi
1. Ensure AirportItlwm loaded
2. Check boot log
3. Try different version

### No Touchpad
1. Use VoodooI2C
2. Try VoodooPS2 fallback
3. Check BIOS settings

### No Sleep
1. Disable hibernation
2. Check USB wake
3. Update NVRAM

### Kernel Panic on Boot
1. Check verbose output
2. Verify SSDTs correct
3. Check kext versions

---

## Post-Install Steps

1. [ ] Map USB ports with USBToolBox
2. [ ] Create UTBMap.kext
3. [ ] Verify all kexts in system
4. [ ] Install updated drivers
5. [ ] Remove `-v` when stable

---

## Expected Results

### Working
- Boot to macOS
- Graphics (limited acceleration)
- Keyboard/touchpad
- Audio (after layout fix)
- USB ports
- Wi-Fi/Bluetooth
- Storage drives
- Battery/sleep

### May Not Work
- HDMI/DP output
- Full GPU acceleration
- DRM content
- Some specialized features