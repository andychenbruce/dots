if status is-login
	set --prepend fish_function_path $HOME/.guix-home/profile/share/fish/functions/
	fenv source $HOME/.cargo/env
	fenv source $HOME/.ghcup/env
	fish_add_path --path $HOME/.local/bin
end

set --unexport fish_greeting

if set -q GUIX_ENVIRONMENT
	set --export --path LD_LIBRARY_PATH $LIBRARY_PATH
end

alias ls "exa"
alias ll "exa --long --git"
alias la "exa --long --git --all"
alias cat "bat --style=plain"

function enter 
	guix shell --check --manifest=$argv
end
