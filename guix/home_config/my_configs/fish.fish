set --unexport fish_greeting ""
set --prepend fish_function_path $HOME/.guix-home/profile/share/fish/functions/
set --export --path LD_LIBRARY_PATH $LIBRARY_PATH
set --export FC_LANG POSIX
set --export GUIX_PROFILE $HOME/.guix-profile

fenv source $HOME/.guix-profile/etc/profile
fenv source $HOME/.cargo/env

fish_add_path -Pa ~/.local/bin
