function proxy_on
    set -gx http_proxy "http://127.0.0.1:7897"
    set -gx https_proxy "http://127.0.0.1:7897"
    set -gx all_proxy "socks5://127.0.0.1:7897"
    
    dbus-update-activation-environment --systemd --all
    echo "Proxy enabled and synced to session"
end

function proxy_off
    set -e http_proxy
    set -e https_proxy
    set -e all_proxy
    
    dbus-update-activation-environment --systemd --all
    echo "Proxy enabled and synced to session"
end