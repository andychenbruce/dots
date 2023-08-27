#!/bin/sh

exec remote-viewer --title "Windows VM" -- "spice+unix://poo.sock"

