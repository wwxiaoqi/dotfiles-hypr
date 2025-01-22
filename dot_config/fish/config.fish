set fish_greeting
set PATH ~/.local/bin $PATH
set -x LC_ALL en_US.UTF-8
export (envsubst < .env)

zoxide init fish | source
bunnyfetch
