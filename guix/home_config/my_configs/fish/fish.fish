set --prepend fish_function_path "$HOME/.guix-home/profile/share/fish/functions"

if status is-login
   fenv source /run/current-system/profile/etc/profile

   set --export HOME_ENVIRONMENT $HOME/.guix-home
   $HOME_ENVIRONMENT/on-first-login
   fenv source $HOME_ENVIRONMENT/setup-environment

   fenv source $HOME/.config/guix/current/etc/profile

   set --path --prepend PATH "/run/setuid-programs"

   eval $(ssh-agent -c)
   trap "ssh-agent -k" exit

   set --export RUSTUP_HOME "$XDG_DATA_HOME"/rustup
   set --export CARGO_HOME "$XDG_DATA_HOME"/cargo
   fenv source $CARGO_HOME/env

   set --path --prepend PATH "$HOME/.local/bin"

   set --export MPD_HOST "/tmp/mpd.sock"
end

function enter
    guix shell --check --manifest=$argv[1]
end

if set --query GUIX_ENVIRONMENT
    set --export LD_LIBRARY_PATH $LIBRARY_PATH
end

if set --query INSIDE_EMACS
  function emacs_dir_track_escape -e fish_prompt
    printf '\032/%s\n' "$PWD" 1>&2
  end
end
