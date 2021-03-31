#!/bin/sh

connection_status() {
    connection=$(sudo wg show "$config_name" 2>/dev/null | head -n 1 | awk '{print $NF }')
    if [ "$connection" = "$config_name" ]; then
        echo "1"
    else
        echo "2"
    fi
}

#config="/etc/wireguard/wg0.conf"
config_name=Feuerwehr

case "$1" in
--toggle)
    echo "XXXXX"
    if [ "$(connection_status)" = "1" ]; then
        nmcli con down id $config_name
    else
        nmcli con up id $config_name
    fi
    ;;
*)
    if [ "$(connection_status)" = "1" ]; then
        echo "%{F#61c766}ﱾ VPN:%{F-} $config_name"
    else
        echo "%{F#ec7875}ﱾ VPN%{F-}"
    fi
    ;;
esac
