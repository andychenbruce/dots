#!/bin/sh


swayidle -w timeout 3 'swaymsg "output * power off"' resume 'swaymsg "output * power on"'
