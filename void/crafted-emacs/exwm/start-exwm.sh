#!/bin/sh

# NOTE: This is only for the live demo, not needed for your configuration!
# spice-vdagent

# Fire it up
exec dbus-launch --exit-with-session emacs -mm --debug-init
