#!/bin/bash

# Check if there are active windows left
if [ "$(hyprctl clients | grep  'no open windows')" ]; then
    # If no active windows, show the zenity confirmation dialog
    zenity --question --text="Shut Down?" && systemctl poweroff;
else
	hyprctl dispatch killactive
fi
