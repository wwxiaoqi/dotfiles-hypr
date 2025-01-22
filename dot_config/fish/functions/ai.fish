function ai
    # 初始化空的 args 数组
    set args

    # 遍历所有参数，处理特殊情况
    for arg in $argv
        # 支持 --format=json 的形式，将其拆分为 --format 和值
        if string match -r -- '^--format=.*' $arg > /dev/null
            set format_value (string replace --regex '^--format=' '' -- $arg)  # 提取等号后的值
            set args $args "--format" $format_value
        else if string match -r -- '^-R.+' $arg > /dev/null
            # 如果参数是 -R 开头的形式，拆分为 --role 和值
            set role_value (string sub -s 3 -- $arg)  # 提取 -R 后的值
            set args $args "--role" $role_value
        else
            set args $args $arg
        end
    end

    # 检查是否包含 --delete-all 参数
    if contains -- "--delete-all" $args
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