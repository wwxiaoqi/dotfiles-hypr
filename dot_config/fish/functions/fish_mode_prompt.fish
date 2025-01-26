# 设置不同模式下的光标形状
function fish_mode_prompt
    # 如果终端是 linux 控制台
    if test $TERM = "linux"
        switch $fish_bind_mode
            case insert
                echo -ne "\e[?0c"  # 插入模式：块状光标
            case default
                echo -ne "\e[?8c"  # 普通模式：下划线光标
        end
    else
        # 如果是其他终端
        switch $fish_bind_mode
            case insert
                echo -ne "\e[6 q"  # 插入模式：块状光标
            case default
                echo -ne "\e[2 q"  # 普通模式：竖线光标
        end
    end
end