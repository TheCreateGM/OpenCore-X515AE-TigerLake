#!/bin/bash
# Quick SMBIOS generator for ASUS X515AE

echo "Generating SMBIOS for MacBookAir9,1..."

# Download macserial
curl -L https://github.com/acidanthera/MacInfoPkg/releases/download/1.0.5/macserial-1.0.5-RELEASE.zip -o macserial.zip && unzip -o macserial.zip macserial && rm macserial.zip

chmod +x macserial

# Generate values
./macserial --generate --model MacBookAir9,1 | head -1 > smbios.txt

echo ""
echo "Generated SMBIOS values:"
echo "----------------------------------------"
echo "Product: MacBookAir9,1"
cat smbios.txt
echo "----------------------------------------"
echo ""
echo "Copy these values into config.plist:"
echo "PlatformInfo > Generic:"
echo "- SystemSerialNumber = first value"
echo "- MLB = second value"
echo "- SystemUUID = generate with: uuidgen"
echo "- ROM = 112233445566"
echo ""

# Generate UUID
echo "Generated UUID: $(uuidgen)"

# Cleanup
rm macserial
