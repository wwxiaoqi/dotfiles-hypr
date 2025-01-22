function ai
    # 初始化空的 args 数组
    set args

    # 遍历所有参数，处理 -R 后紧跟值的情况
    for arg in $argv
        if string match -r -- '^-R.+' $arg > /dev/null
            # 如果参数是 -R 开头的形式，拆分为 --role 和值
            set role_value (string sub -s 3 -- $arg)  # 提取 -R 后的值
            set args $args "--role" $role_value
        else
            set args $args $arg
        end
    end

    # 添加了自动全部删除命令 --delete-all
    if contains -- "--delete-all" $args
        set ids (mods --list | awk '{print $1}')
        set count (echo $ids | wc -w)

        # 循环使用 --delete 参数删除
        for id in $ids
            mods --delete="$id"
        end

        echo "Deleted $count conversations."
    else
        EDITOR=vim mods $args
    end
end

# 自动补全配置
complete -c ai -w mods
complete -c ai -l delete-all -d "Deletes all saved conversations."
complete -c ai -s d -l delete -a "(mods --list | awk '{print $1}')" -d "Deletes conversations for list ID"
complete -c ai -s R -l role -a "(mods --list-roles | grep -v 'default (default)' | awk '{print $1}')" -d "Sets the role for the AI."