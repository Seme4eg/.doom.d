#!/bin/sh
#!/usr/bin/env bash

# run the screen compositor
picom & # new name for 'compton'

# -mm -- maximise emacs window on startup
exec dbus-launch --exit-with-session emacs -mm --debug-init -l ~/.doom.d/config.el
