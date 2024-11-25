set fish_greeting
set PATH ~/.local/bin $PATH
set -x LC_ALL en_US.UTF-8

zoxide init fish | source

# cuda
set PATH /opt/cuda/bin $PATH
set LD_LIBRARY_PATH /opt/cuda/lib64 $LD_LIBRARY_PATH

bunnyfetch
