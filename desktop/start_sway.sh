#!/bin/sh

dbus-run-session sway 

killall -w wireplumber
killall -w pipewire-pulse
killall -w pipewire
