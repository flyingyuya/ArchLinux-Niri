if status is-interactive
	# Commands to run in interactive sessions can go here
	# 关闭欢迎语
	set fish_greeting ""
	# 终端美化
	starship init fish | source
end

set -gx http_proxy "http://127.0.0.1:7897"
set -gx https_proxy "http://127.0.0.1:7897"
set -gx all_proxy "socks5://127.0.0.1:7897"
set -gx no_proxy "localhost,127.0.0.1,localaddress,.localdomain.com"

# 激活 pipx 和 uv 环境
fish_add_path "$HOME/.local/bin"

# 激活 Ruby Gem
fish_add_path "$HOME/.local/share/gem/ruby/3.4.0/bin"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/miniforge3/bin/conda
    eval /opt/miniforge3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/miniforge3/etc/fish/conf.d/conda.fish"
        . "/opt/miniforge3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/miniforge3/bin" $PATH
    end
end
# <<< conda initialize <<<

