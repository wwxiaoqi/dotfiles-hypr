#!/bin/bash

while true; do
    # 捕获当前剪贴板内容
    clipboard_content=$(wl-paste)

    # 使用 sed 移除尾随的新行
    # ':a' 是一个标签
    # '^$' 匹配一个空行
    # '{d; N;}' 删除空行并读取下一行
    # '/\n$/' 匹配以新行结尾的行
    # 'ba' 是一个分支到标签 a 的指令
    cleaned_content=$(echo "$clipboard_content" | sed ':a; /^$/{$d; N;}; /\n$/ba')
    
    # 将清理后的内容放回剪贴板
    echo -n "$cleaned_content" | xclip -selection clipboard

    # 使用 xclip 将剪贴板内容设置为其本身（可选的冗余步骤）
    # 二次确定，确保剪贴板内容保持不变
    xclip -selection clipboard -o | wl-copy

    # 等待 0.5 秒后进行下一次迭代
    sleep 0.5
done
