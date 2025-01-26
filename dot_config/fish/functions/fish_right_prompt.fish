function fish_right_prompt
    set -l cwd
    set -l cwd_color (set_color blue)
    set -l normal_color (set_color normal)
    set -l branch_color (set_color yellow)
    set -l meta_color (set_color red)
    set -l SHOW_GIT_PATH 0

    # 检查是否是 Git 仓库
    if git_is_repo
        echo -n -s $branch_color (git_branch_name) $normal_color
        set -l git_meta ""
        if test (command git ls-files --others --exclude-standard | wc -w 2> /dev/null) -gt 0
            set git_meta "$git_meta?"
        end
        if test (command git rev-list --walk-reflogs --count refs/stash 2> /dev/null)
            set git_meta "$git_meta\$"
        end
        if git_is_touched
            git_is_dirty && set git_meta "$git_meta⨯"
            git_is_staged && set git_meta "$git_meta●"
        end
        set -l commit_count (command git rev-list --count --left-right (git remote)/(git_branch_name)"...HEAD" 2> /dev/null)
        if test $commit_count
            set -l behind (echo $commit_count | cut -f 1)
            set -l ahead (echo $commit_count | cut -f 2)
            if test $behind -gt 0
                set git_meta "$git_meta🠋"
            end
            if test $ahead -gt 0
                set git_meta "$git_meta🠉"
            end
        end
        if test $git_meta
            echo -n -s $meta_color " " $git_meta " " $normal_color
        else
            echo -n -s " "
        end

        # 判断是否显示路径
        if set -q SHOW_GIT_PATH
            if test $SHOW_GIT_PATH -eq 1
                set root_folder (command git rev-parse --show-toplevel 2> /dev/null)
                set parent_root_folder (dirname $root_folder)
                set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
            end
        end
    else
        # 如果不是 Git 仓库，直接显示当前路径
        if set -q SHOW_GIT_PATH
            if test $SHOW_GIT_PATH -eq 1
                set cwd (prompt_pwd)
            end
        end
    end

    # 输出路径（如果启用了路径显示）
    if test -n "$cwd"
        echo -n -s $cwd_color "$cwd"
    end
    set_color --dim

    # 显示命令执行时间
    set -l S (math $CMD_DURATION/1000)
    set -l M (math $S/60)

    echo -n -s " "
    if test $M -gt 1
        echo -n -s $M m
    else if test $S -gt 1
        echo -n -s $S s
    else
        echo -n -s $CMD_DURATION ms
    end
    set_color normal
end