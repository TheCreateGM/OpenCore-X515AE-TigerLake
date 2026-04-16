#!/bin/bash
# USB Mapping helper for ASUS X515AE

echo "Downloading USBToolBox..."

# Download UTBMap
curl -L https://github.com/USBToolBox/kext/releases/download/1.1.2/USBToolBox-1.1.2-RELEASE.zip -o utb.zip && unzip -o utb.zip && rm utb.zip

echo ""
echo "✅ USBToolBox downloaded"
echo ""
echo "USB Mapping Instructions:"
echo "----------------------------------------"
echo "1. Boot into Windows (recommended) or macOS"
echo "2. Run USBToolBox tool"
echo "3. Click 'Discover Ports'"
echo "4. Plug USB 2.0 device into EVERY port"
echo "5. Plug USB 3.0 device into EVERY port"
echo "6. Mark ports as Internal/External"
echo "7. Export UTBMap.kext"
echo "8. Copy to EFI/OC/Kexts/"
echo ""
echo "X515AE Typical Ports:"
echo "- USB-C (1x)"
echo "- USB-A 3.0 (2x left)"
echo "- USB-A 2.0 (1x right)"
echo "- Internal: Webcam, Bluetooth"
echo ""
echo "⚠️  MAX 15 PORTS - disable unused!"
echo "----------------------------------------"

# Move to Kexts folder
mv USBToolBox.kext EFI/OC/Kexts/ 2>/dev/null || true

echo ""
echo "USBToolBox.kext copied to EFI/OC/Kexts/"
