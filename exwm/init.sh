#!/bin/sh
. ~/.profile              # Source .profile for common environment vars
xhost +SI:localuser:$USER # Disable access control for the current user
xsettingsd &              # Run xsettingsd to progagate font and theme settings
xset -b                   # Turn off the system bell
xss-lock -- slock &       # Enable screen locking on suspend
xset r rate 200 60 # Set keyboard repeat rate.

# Make Java applications aware this is a non-reparenting window manager.
export _JAVA_AWT_WM_NONREPARENTING=1

# run the screen compositor
picom & # new name for 'compton'

# -mm -- maximise emacs window on startup
exec dbus-launch --exit-with-session emacs -mm --debug-init --use-exwm
