#!/bin/bash

# Define the location of your compiled firmware files
FIRMWARE_DIR="firmware"

# Get the latest firmware file with "_left" in the name
LATEST_FIRMWARE=$(ls -t $FIRMWARE_DIR/*-left* | head -n 1)

echo $LATEST_FIRMWARE

# Check for a newly connected USB device
DEVICE=/dev/disk/by-label/ADV360PRO

# Exit if no device is detected
# if [ -z "$DEVICE" ]; then
#     echo "No USB device detected."
#     exit 1
# fi

# Check device in for loop up to 5 times with 1 second sleep between each check
for i in {1..10}
do
    if [ -e "$DEVICE" ]; then
        echo "USB device detected."
        break
    else
        echo "No USB device detected."
        sleep 1
    fi
done

# Mount the device to /media (you may need to adjust this)
# mkdir -p /media/usb
mount $DEVICE /media/usb

# Copy the latest firmware to the mounted device
cp "$LATEST_FIRMWARE" /media/usb/

# (Optional) Unmount the device after copying
umount /media/usb

echo "Firmware updated successfully."
