set --unexport fish_greeting ""
set --prepend fish_function_path $HOME/.guix-home/profile/share/fish/functions/
set --export FC_LANG POSIX
set --export GUIX_PROFILE $HOME/.guix-profile
fenv source $HOME/.guix-profile/etc/profile

fish_add_path -Pa ~/.local/bin

