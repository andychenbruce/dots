#!/bin/sh

swayidle -w \
	 timeout 1 'swaylock -f --color 000000' \
	 timeout 1 'swaymsg "output * power off"' resume 'swaymsg "output * power on"'
