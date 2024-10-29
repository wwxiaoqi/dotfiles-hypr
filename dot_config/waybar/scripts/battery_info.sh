#!/bin/bash

# 定义不同电量状态下的图标数组
icons=("" "" "")
icon_index=0

## 获取当前电量百分比
percentage=$(cat /sys/class/power_supply/BAT0/capacity)

## 获取充电状态
charging=$(cat /sys/class/power_supply/BAT0/status)

## 获取电池剩余时间并格式化
remaining_time=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "time to empty" | awk '{print$4}')
remaining_time_formatted=$(echo $remaining_time | awk  -F'.' '{print $1" h "$2" min"}')

# 如果获取到的时间是空的或者电池正在充电，设置默认信息
if [ -z "$remaining_time" ] || [ "$charging" == "Charging" ]; then
    battery_time="Charging"
else
    battery_time="Time to empty: $remaining_time_formatted"
fi

# 如果电量是100%，则固定显示最后一个图标
if [ "$percentage" -eq 100 ]; then
    icon_index=$((${#icons[@]} - 1))
# 如果电池没有在充电且电量不是100%，显示第二个图标
elif [ "$charging" != "Charging" ]; then
    icon_index=1
else
    # 生成一个随机索引
    icon_index=$((RANDOM % (${#icons[@]})))
fi

# 输出 JSON 格式的数据
# 输出 JSON 格式的数据
jq -c -n --arg text "${icons[$icon_index]} $percentage%" --arg tooltip "$battery_time" '{"text": $text, "tooltip":$tooltip}'
