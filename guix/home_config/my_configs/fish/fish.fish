set --prepend fish_function_path "$HOME/.guix-home/profile/share/fish/functions"

function source_profile
  set --function --export GUIX_PROFILE "$argv[1]"
  fenv source "$argv[1]/etc/profile"
end

if status is-login
  set --path --erase PATH

  source_profile /run/current-system/profile
  fish_add_path --global --path "/run/setuid-programs"

  source_profile "$HOME/.config/guix/current"

  set HOME_ENVIRONMENT "$HOME/.guix-home"
  fenv source $HOME_ENVIRONMENT/setup-environment
  $HOME_ENVIRONMENT/on-first-login

  eval $(ssh-agent -c)
  trap "ssh-agent -k" exit

  fish_add_path --global --path "$HOME/.local/bin"
  set --export MPD_HOST "/tmp/mpd.sock"
end

function enter
  guix shell --check --manifest=$argv[1]
end

switch $TERM
case "eterm*"
  function emacs_dir_track_escape --on-event fish_prompt
    printf '\032/%s\n' "$PWD" 1>&2
  end
end
