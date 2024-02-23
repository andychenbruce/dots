set --prepend fish_function_path "$HOME/.guix-home/profile/share/fish/functions"

if status is-login
   fenv source /etc/profile
   set --export HOME_ENVIRONMENT $HOME/.guix-home
   fenv source $HOME_ENVIRONMENT/setup-environment
   $HOME_ENVIRONMENT/on-first-login

   eval $(ssh-agent -c)
   trap "ssh-agent -k" exit

   set --export CARGO_HOME "$XDG_DATA_HOME"/cargo
   set --export RUSTUP_HOME "$XDG_DATA_HOME"/rustup

   fenv source $CARGO_HOME/env

   set --path --prepend PATH "$HOME/.local/bin:$PATH"
end

function enter
    guix shell --check --manifest=$argv[1]
end

if set --query GUIX_ENVIRONMENT
    set --export LD_LIBRARY_PATH $LIBRARY_PATH
end

