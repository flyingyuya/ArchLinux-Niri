#!/usr/bin/env bash

# 定义 Pot 缓存路径
CACHE_PATH="$HOME/.cache/com.pot-app.desktop/pot_screenshot_cut.png"

# 1. 确保目录存在
mkdir -p "$(dirname "$CACHE_PATH")"

# 2. 删除旧截图
rm -f "$CACHE_PATH"

# 3. 使用 grim 和 slurp 进行区域截图并保存到指定位置
# -g "$(slurp)" 会让你用鼠标拉框
# 如果拉框被取消（按 Esc），grim 会报错，后面就不会执行 curl
grim -g "$(slurp)" "$CACHE_PATH" && \
curl "127.0.0.1:60828/ocr_translate?screenshot=false"
