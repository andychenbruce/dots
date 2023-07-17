
killall -w wireplumber
killall -w pipewire-pulse
killall -w pipewire

dbus-update-activation-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway


$HOME/.guix-home/profile/libexec/xdg-desktop-portal -r &

sleep 5

exec pipewire &
exec pipewire-pulse &
exec wireplumber &

