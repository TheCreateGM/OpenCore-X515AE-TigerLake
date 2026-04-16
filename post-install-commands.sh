#!/bin/bash
# Post-install commands for ASUS X515AE

echo "Running post-install optimizations..."

# Disable hibernation
sudo pmset -a hibernatemode 0
sudo pmset -a standby 0
sudo pmset -a autopoweroff 0
sudo pmset -a sleep 10
sudo pmset -a womp 0
sudo pmset -a networkoversleep 0

# Disable Gatekeeper
sudo spctl --master-disable

# Allow any application
sudo defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool false

# Rebuild kext cache
sudo kextcache -i /

# Disable sleep image
sudo rm -f /private/var/vm/sleepimage
sudo touch /private/var/vm/sleepimage
sudo chflags uchg /private/var/vm/sleepimage

# Optimize for SSD
sudo defaults write -g NSWindowResizeTime -float 0.001

echo ""
echo "✅ Post-install commands complete!"
echo ""
echo "Recommended next steps:"
echo "1. Reboot system"
echo "2. Test sleep/wake"
echo "3. Verify all hardware working"
echo "4. Run Hackintool for verification"
