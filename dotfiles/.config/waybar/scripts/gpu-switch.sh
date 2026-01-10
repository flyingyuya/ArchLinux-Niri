#!/usr/bin/env bash

# 定义“静态变量”存储文件路径（放在内存中，重启自动消失）
BOOT_MODE_FILE="/tmp/gpu_boot_mode"

# 1. 获取实时模式 (envycontrol 当前认为的模式)
# 如果你刚点完切换，它会输出下次的模式
current_raw=$(envycontrol -q)

if [[ "$current_raw" == *"nvidia"* ]]; then
    mode_now="nvidia"
    label="NVIDIA (独显)"
    icon="󰢮"
elif [[ "$current_raw" == *"integrated"* ]]; then
    mode_now="integrated"
    label="Integrated (集显)"
    icon="󰈐"
else
    mode_now="hybrid"
    label="Hybrid (混合)"
    icon="󰢮"
fi

# 2. 模拟静态变量：记录“本次开机时的模式”
if [ ! -f "$BOOT_MODE_FILE" ]; then
    # 第一次运行脚本，记录下最初的模式
    echo "$mode_now" > "$BOOT_MODE_FILE"
fi
boot_mode=$(cat "$BOOT_MODE_FILE")

# 3. 输出给 Waybar
if [[ "$1" == "status" ]]; then
    class="$mode_now"
    status_msg=""

    # 核心判断：如果实时模式和开机模式不一样，说明已经点了切换，正在等待重启
    if [[ "$mode_now" != "$boot_mode" ]]; then
        status_msg="\n\n⚠️ 模式已更改！(当前仍在使用旧模式)\n重启后将进入: $label\n"
        class="pending" # 触发 CSS 红色闪烁
    fi

    echo "{\"text\": \"$icon\", \"tooltip\": \"当前运行: $boot_mode\n预设下次: $label$status_msg\n左键: 混合 | 右键: 独显 | 中键: 集显\", \"class\": \"$class\"}"
fi
