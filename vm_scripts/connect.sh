#!/usr/bin/env bash

exec remote-viewer --title "虚拟机" --auto-resize never -- "spice+unix://poo.sock"

