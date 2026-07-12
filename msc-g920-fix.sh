#!/bin/bash

DEVICE=$(ls /dev/input/by-id/ 2>/dev/null | grep -i "G920.*event-joystick" | head -n 1)

if [ -z "$DEVICE" ]; then
    echo "ERROR: G920 not found. Make sure it's plugged in before running this script."
    echo ""
    read -p "Press Enter to exit..."
    exit 1
fi

DEVICE_PATH="/dev/input/by-id/$DEVICE"

apply_fix() {
    echo "Applying G920 axis fix for My Summer Car..."
    echo "Device: $DEVICE_PATH"
    echo ""

    evdev-joystick --e "$DEVICE_PATH" -a 0 -m -65534 -M 65534 && echo "  [OK] Steering Wheel" || echo "  [FAIL] Steering Wheel"
    evdev-joystick --e "$DEVICE_PATH" -a 1 -m -255 -M 255   && echo "  [OK] Throttle"       || echo "  [FAIL] Throttle"
    evdev-joystick --e "$DEVICE_PATH" -a 2 -m -255 -M 255   && echo "  [OK] Brake"          || echo "  [FAIL] Brake"
    evdev-joystick --e "$DEVICE_PATH" -a 5 -m -255 -M 255   && echo "  [OK] Clutch"         || echo "  [FAIL] Clutch"

    echo ""
    echo "Done! You can now launch My Summer Car."
}

remove_fix() {
    echo "Removing G920 axis fix (restoring Linux defaults)..."
    echo "Device: $DEVICE_PATH"
    echo ""

    evdev-joystick --e "$DEVICE_PATH" -a 0 -m 0 -M 32767 && echo "  [OK] Steering Wheel" || echo "  [FAIL] Steering Wheel"
    evdev-joystick --e "$DEVICE_PATH" -a 1 -m 0 -M 255   && echo "  [OK] Throttle"       || echo "  [FAIL] Throttle"
    evdev-joystick --e "$DEVICE_PATH" -a 2 -m 0 -M 255   && echo "  [OK] Brake"          || echo "  [FAIL] Brake"
    evdev-joystick --e "$DEVICE_PATH" -a 5 -m 0 -M 255   && echo "  [OK] Clutch"         || echo "  [FAIL] Clutch"

    echo ""
    echo "Done! Axes restored to Linux defaults."
}

echo "=============================="
echo "  MSC G920 Linux Axis Fix"
echo "=============================="
echo ""
echo "  1) Apply fix   (before playing MSC)"
echo "  2) Remove fix  (restore Linux defaults)"
echo "  3) Exit"
echo ""
read -p "Choose [1/2/3]: " choice

case "$choice" in
    1) echo ""; apply_fix ;;
    2) echo ""; remove_fix ;;
    3) exit 0 ;;
    *) echo "Invalid choice. Exiting."; exit 1 ;;
esac

echo ""
read -p "Press Enter to close..."
