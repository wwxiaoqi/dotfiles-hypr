function ai
    # 初始化空的 args 数组
    set args
    # 用于跳过已经处理的参数
    set skip_next 0

    # 遍历所有参数
    for i in (seq (count $argv))
        if test $skip_next -eq 1
            set skip_next 0
            continue
        end

        set arg $argv[$i]

        # 支持 --role=shell 的形式，将其拆分为 --role 和值
        if string match -r -- '^--role=.*' $arg > /dev/null
            set role_value (string replace --regex '^--role=' '' -- $arg)
            set args $args "--role" $role_value

        # 支持 --role shell 的形式
        else if string match -r -- '^--role$' $arg > /dev/null
            if test (count $argv) -ge (math $i + 1)
                set role_value $argv[(math $i + 1)]
                set args $args "--role" $role_value
                set skip_next 1  # 跳过下一个参数
            else
                echo "Error: --role requires a value." >&2
                return 1
            end

        # 支持 -R 和 -Rshell 的形式
        else if string match -r -- '^-R$' $arg > /dev/null
            # 如果参数是单独的 -R，取下一个参数作为 role 值
            if test (count $argv) -ge (math $i + 1)
                set role_value $argv[(math $i + 1)]
                set args $args "--role" $role_value
                set skip_next 1  # 跳过下一个参数
            else
                echo "Error: -R requires a value." >&2
                return 1
            end
        else if string match -r -- '^-R.+' $arg > /dev/null
            # 如果参数是 -R 开头并直接跟值的形式
            set role_value (string sub -s 3 -- $arg)
            set args $args "--role" $role_value

        # 支持其他参数
        else
            set args $args $arg
        end
    end

    # 检查是否包含 --delete-all 参数
    if string match -q -- "--delete-all" $args
        set ids (mods --list | awk '{print $1}')
        set count (echo $ids | wc -w)

        if test "$count" -eq 0
            echo "No conversations to delete."
        else
            # 循环删除所有会话
            for id in $ids
                mods --delete="$id"
            end
            echo "Deleted $count conversations."
        end
    else
        # 默认使用 vim 编辑器运行 mods 命令
        EDITOR=vim mods $args
    end
end

# 动态读取 mods.yml 中的 format-text 配置
function get_formats
    awk '/format-text:/,/^$/' /home/xiaoqi/.config/mods/mods.yml | grep -oP '^\s+\K\w+(?=:)'
end

# 自动补全配置
complete -c ai -w mods
complete -c ai -l delete-all -d "Deletes all saved conversations."
complete -c ai -s d -l delete -a "(mods --list | awk '{print $1}')" -d "Deletes conversations for list ID"
complete -c ai -s R -l role -a "(mods --list-roles | grep -v 'default (default)' | awk '{print $1}')" -d "Sets the role for the AI."
complete -c ai -s f -l format -a "(get_formats)" -d "Set the output format (e.g., markdown or json)." -f