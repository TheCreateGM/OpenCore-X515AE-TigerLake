#!/bin/bash
# Download script for OpenCore X515AE kexts
# Run from OpenCore-X515AE-TigerLake directory

echo "Downloading kexts for ASUS X515AE..."

# Create directories
mkdir -p ../EFI/OC/Kexts
mkdir -p ../EFI/OC/ACPI
mkdir -p ../EFI/OC/Drivers

cd ../EFI/OC/Kexts

# Core Kexts
curl -L "https://github.com/acidanthera/Lilu/releases/download/1.6.8/Lilu-1.6.8-RELEASE.zip" -o lilu.zip && unzip -o lilu.zip && rm lilu.zip
curl -L "https://github.com/acidanthera/VirtualSMC/releases/download/1.3.2/VirtualSMC-1.3.2-RELEASE.zip" -o smc.zip && unzip -o smc.zip && rm smc.zip
curl -L "https://github.com/acidanthera/WhateverGreen/releases/download/1.6.7/WhateverGreen-1.6.7-RELEASE.zip" -o weg.zip && unzip -o weg.zip && rm weg.zip

# Audio
curl -L "https://github.com/acidanthera/AppleALC/releases/download/1.8.9/AppleALC-1.8.9-RELEASE.zip" -o alc.zip && unzip -o alc.zip && rm alc.zip

# VoodooI2C (for ELAN touchpad)
curl -L "https://github.com/VoodooI2C/VoodooI2C/releases/download/v2.9.8/VoodooI2C-2.9.8-RELEASE.zip" -o viad.zip && unzip -o viad.zip && rm viad.zip

# Intel Wi-Fi (AX201)
curl -L "https://github.com/OpenIntelWireless/itlwm/releases/download/v2.3.0/AirportItlwm_v2.3.0_stable_Sonoma.kext.zip" -o wifi.zip && unzip -o wifi.zip && rm wifi.zip

# Intel Bluetooth
curl -L "https://github.com/OpenIntelWireless/IntelBluetoothFirmware/releases/download/v2.6.0/IntelBluetoothFirmware-v2.6.0.zip" -o bt.zip && unzip -o bt.zip && rm bt.zip

# BlueToolFixup
curl -L "https://github.com/acidanthera/BrcmPatchRAM/releases/download/2.6.8/BrcmPatchRAM-2.6.8-RELEASE.zip" -o btfix.zip && unzip -o btfix.zip BlueToolFixup.kext && rm btfix.zip

# CPUFriend
curl -L "https://github.com/acidanthera/CPUFriend/releases/download/1.2.6/CPUFriend-1.2.6-RELEASE.zip" -o cf.zip && unzip -o cf.zip && rm cf.zip

# NVMeFix
curl -L "https://github.com/acidanthera/NVMeFix/releases/download/1.1.2/NVMeFix-1.1.2-RELEASE.zip" -o nvme.zip && unzip -o nvme.zip && rm nvme.zip

# BrightnessKeys
curl -L "https://github.com/acidanthera/BrightnessKeys/releases/download/1.0.3/BrightnessKeys-1.0.3-RELEASE.zip" -o br.zip && unzip -o br.zip && rm br.zip

# ECEnabler
curl -L "https://github.com/1Revenger1/ECEnabler/releases/download/v1.0.4/ECEnabler-1.0.4-RELEASE.zip" -o ec.zip && unzip -o ec.zip && rm ec.zip

# USBToolBox
curl -L "https://github.com/USBToolBox/kext/releases/download/1.1.2/USBToolBox-1.1.2-RELEASE.zip" -o utb.zip && unzip -o utb.zip && rm utb.zip

# AsusSMC
curl -L "https://github.com/hieplpvip/AsusSMC/releases/download/1.4.2/AsusSMC-1.4.2-RELEASE.zip" -o asus.zip && unzip -o asus.zip && rm asus.zip

# SSDT-GPIO
cd ../ACPI
curl -L "https://raw.githubusercontent.com/dortania/Getting-Started-With-ACPI/master/extra-files/compiled/SSDT-GPIO.aml" -o SSDT-GPIO.aml

# Copy all SSDTs from project
cp ../../../OpenCore-X515AE-TigerLake/EFI/OC/ACPI/*.aml .

# VoodooPS2
cd ../Kexts
curl -L "https://github.com/acidanthera/VoodooPS2/releases/download/2.3.5/VoodooPS2-2.3.5-RELEASE.zip" -o ps2.zip && unzip -o ps2.zip && rm ps2.zip

echo "Done! All kexts downloaded to EFI/OC/Kexts"
echo "SSDT-GPIO.aml downloaded to EFI/OC/ACPI"
