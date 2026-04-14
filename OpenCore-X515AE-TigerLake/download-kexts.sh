#!/bin/bash
# Download script for additional kexts
# Run from EFI/OC/Kexts folder

echo "Downloading additional kexts..."

# VoodooI2C (for ELAN touchpad)
curl -L -k "https://github.com/acidanthera/VoodooI2C/releases/download/2.9.8/VoodooI2C-2.9.8-RELEASE.zip" -o viad.zip && unzip -o viad.zip && rm viad.zip

# Intel Wi-Fi (AX201)
curl -L -k "https://github.com/OpenIntelWireless/itlwm/releases/download/v2.3.0/itlwm-2.3.0-Sonoma.zip" -o wifi.zip && unzip -o wifi.zip && rm wifi.zip

# Intel Bluetooth
curl -L -k "https://github.com/OpenIntelWireless/IntelBluetoothFirmware/releases/download/v2.6.0/IntelBluetoothFirmware-2.2.0.zip" -o bt.zip && unzip -o bt.zip && rm bt.zip

# BlueToolFixup
curl -L -k "https://github.com/acidanthera/BluS/releases/download/2.1.0/BluS-2.1.0-RELEASE.zip" -o btfix.zip && unzip -o btfix.zip && rm btfix.zip

# CPUFriend
curl -L -k "https://github.com/acidanthera/CPUFriend/releases/download/1.2.3/CPUFriend-1.2.3-RELEASE.zip" -o cf.zip && unzip -o cf.zip && rm cf.zip

# NVMeFix
curl -L -k "https://github.com/acidanthera/NVMeFix/releases/download/1.1.2/NVMeFix-1.1.2-RELEASE.zip" -o nvme.zip && unzip -o nvme.zip && rm nvme.zip

# BrightnessKeys
curl -L -k "https://github.com/acidanthera/BrightnessKeys/releases/download/1.0.3/BrightnessKeys-1.0.3-RELEASE.zip" -o br.zip && unzip -o br.zip && rm br.zip

# ECEnabler
curl -L -k "https://github.com/acidanthera/ECEnabler/releases/download/1.0.3/ECEnabler-1.0.3-RELEASE.zip" -o ec.zip && unzip -o ec.zip && rm ec.zip

# USBToolBox
curl -L -k "https://github.com/USBToolBox/tool/releases/download/v1.0.0/UTB.zip" -o utb.zip && unzip -o utb.zip && rm utb.zip

echo "Done! Check kexts folder."