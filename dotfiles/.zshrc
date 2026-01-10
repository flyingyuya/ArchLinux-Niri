# 交互环境启用
if [[ $- == *i* ]]; then
	# 终端美化
	eval "$(starship init zsh)"
fi

# 语法检查和高亮
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# 开启tab选择补全
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit

# 设置历史记录文件的路径
HISTFILE=~/.zsh_history

# 设置在会话（内存）中和历史文件中保存的条数，建议设置得大一些
HISTSIZE=1000
SAVEHIST=1000

# 忽略重复的命令，连续输入多次的相同命令只记一次
setopt HIST_IGNORE_DUPS

# 忽略以空格开头的命令（用于临时执行一些你不想保存的敏感命令）
setopt HIST_IGNORE_SPACE

# 在多个终端之间实时共享历史记录 
# 这是实现多终端同步最关键的选项
setopt SHARE_HISTORY

# 让新的历史记录追加到文件，而不是覆盖
setopt APPEND_HISTORY
# 在历史记录中记录命令的执行开始时间和持续时间
setopt EXTENDED_HISTORY

# 代理
export http_proxy="http://127.0.0.1:7897"
export https_proxy="http://127.0.0.1:7897"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# === 修复 Ctrl + 左/右 箭头跨词移动 ===
# 检查 zsh 版本是否支持 Key bindings
if [ -n "$ZSH_VERSION" ]; then
    # 绑定 'Ctrl + 右箭头' 到 forward-word
    # 常用序列: ^[[1;5C (xfce, gnome, etc.)
    # 绑定 'Ctrl + 左箭头' 到 backward-word
    # 常用序列: ^[[1;5D (xfce, gnome, etc.)
    
    bindkey '^[[1;5C' forward-word
    bindkey '^[[1;5D' backward-word

    # 尝试另一种常见的序列 (有时是 ^[[5C/D)
    bindkey '\e[5C' forward-word
    bindkey '\e[5D' backward-word
fi

# 激活 pipx 和 uv 环境
export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# 激活 Ruby Gem
export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"

