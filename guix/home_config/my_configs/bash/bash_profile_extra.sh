source ~/.cargo/env
PATH=~/.local/bin:$PATH
eval $(ssh-agent)
trap 'kill $SSH_AGENT_PID' EXIT
