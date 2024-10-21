function bunnyfetch
    command tput clear
    set packages (pacman -Qqe | wc -l)
    set wmname "Arch Linux"
    set kernal (uname -r | cut -d '-' -f1)
    set resolution (xrandr --listmonitors | grep / | awk  -F'[ /x]' '{sum += $4} END {printf sum"x"$6" "}')
    set shellname (basename $SHELL)
    echo ""
    echo "             "(set_color red) □ (set_color normal) $wmname
    echo "    (\ /)    "(set_color yellow) □ (set_color normal) $kernal
    echo "    ( . .)   "(set_color green) □ (set_color normal) Fish
    echo "    c("(set_color red)'"'(set_color normal)")("(set_color red)'"'(set_color normal)")  "(set_color magenta) □  (set_color normal) $resolution
    echo "             "(set_color blue) □ (set_color normal) $packages
    echo ""
end

