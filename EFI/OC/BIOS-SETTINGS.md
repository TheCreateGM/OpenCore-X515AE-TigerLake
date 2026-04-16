# BIOS Settings - ASUS VivoBook X515AE

## Required BIOS Changes

### Disable (or Disable)

| Setting | Value | Notes |
|---------|-------|-------|
| Secure Boot | Disabled | Required for OpenCore |
| Fast Boot | Disabled | Prevents EFI changes |
| VMD Controller | Disabled | **CRITICAL** - NVMe will NOT work if enabled |
| BIOS Recovery | Disable | Not needed |

### Enable (or Enable)

| Setting | Value | Notes |
|---------|-------|-------|
| AHCI Mode | Enabled | For SATA SSD |
| XHCI Hand-off | Enabled | USB load fix |
| EHCI Hand-off | Enabled | USB compatibility |
| Launch CSM | Disabled | Use UEFI only |

### Configure

| Setting | Value | Notes |
|---------|-------|-------|
| Boot Type | UEFI | Required |
| Boot Priority | UEFI First | |
| DVMT Pre-Alloc | 64MB or 128MB | Fixes graphics |
|CFG Lock | Disabled or Unlock | See below |

## CFG Lock (Critical)

### If Available
1. **Disable** CFG Lock in BIOS
2. If no option, use CFGUnlock tool

### Using CFGUnlock (If Needed)
```bash
# In Windows/DOS
cfgunlock disable
```

### Kernel Quirk Alternative
If cannot disable:
```
AppleXcpmCfgLock: YES
```
(In config.plist)

## DVMT Pre-Allocation

### Setting Location
Advanced > Graphics > DVMT Pre-Alloc

### Recommended
- **64MB** (minimum)
- **128MB** (recommended for better iGPU)

### Without This
- Graphics issues
- Limited VRAM
- Kernel panic possible

## Enter BIOS

### Key
- **F2** or **Delete** on boot
- Hold during POST

### Boot Menu
- **F8** for boot menu

## Boot Order

1. Set EFI partition as first boot
2. Disable other options
3. Save and exit

## Save & Exit

1. Press **F10** to save
2. Confirm
3. System reboots

---

## Quick Summary

```
Required Changes:
- Disable Secure Boot
- Disable Fast Boot  
- **DISABLE VMD CONTROLLER** (Critical for NVMe)
- Enable AHCI Mode
- Enable XHCI/EHCI Hand-off
- Set DVMT to 64MB+
- Disable CFG Lock (or patch)
- Use UEFI Boot
```

## After Installation

1. Keep BIOS settings
2. Update only if needed
3. Record original settings

---

## Advanced Tweaks (Optional)

### Performance
- Disable C-States: Keep enabled (power management)
- SpeedStep: Keep enabled
- Turbo Boost: Keep enabled

### USB
- USB 3.0 Mode: Enabled
- XHCI Pre-boot: Enabled (debug)

### Virtualization
- Intel VT-x: Keep enabled (may help)
- VT-d: Keep enabled