# Linux Wheel Fixer

This script aims to fix a centering issue with Logitech wheels for the game My Summer Car.

**What does this script do?**

It uses Joystick to map your wheel to use the range that My Summer Car expects (Negative range)

A .sh file is a filesystem used by linux to execute instructions in a row like a user would in a terminal.

## How do I use this script?

First you must install the package called Joystick to edit range values for your wheel.

For Debian and Ubuntu
`` sudo apt install joystick ``

For Arch based systems (CachyOS etc)
`` sudo pacman -S joystick ``

**If your wheel is a G920, Skip this next step**

This script is setup exclusively for the G920 and G29 (untested).
Therefore you may need to change values in the script to work with your wheel.

To find the values you need for your system, run:
``ls /dev/input/by-id/ | grep -i logitech (or your wheel manufacturer)``

Then replace all values the represent your Logitech ID inside the script, most notably 
``DEVICE=$(ls /dev/input/by-id/ 2>/dev/null | grep -i "G920.*event-joystick" | head -n 1)``
For example, g920.*event-joystick , in the above snippet.

**Finally,** You must run the script:
``./msc-g920-fix.sh``

## For any errors, make an Issue or Contact me on discord: foxache#0100
