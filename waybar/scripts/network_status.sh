#!/bin/bash

# Interfaces a chequear (puedes modificar según tus interfaces reales)
WIFI_IFACES=("wlan0" "wlan1")
ETH_IFACES=("enp0s25")

# Función para obtener IP IPv4 de una interfaz
get_ip() {
    ip -4 addr show "$1" | grep -oP '(?<=inet\s)\d+(\.\d+){3}'
}

# Obtener IP pública (timeout 3 seg)
get_public_ip() {
    curl -s --max-time 3 https://ipinfo.io/ip
}

public_ip=$(get_public_ip)

# Chequear Ethernet primero
for iface in "${ETH_IFACES[@]}"; do
    if ip link show "$iface" | grep -q "state UP"; then
        ip_addr=$(get_ip "$iface")
        if [ -n "$ip_addr" ]; then
            echo "{\"text\":\" Ethernet\",\"tooltip\":\"$iface - Ethernet\nIP Local: $ip_addr\nIP Pública: $public_ip\",\"class\":\"connected\"}"
            exit 0
        fi
    fi
done

# Luego chequear WiFi
for iface in "${WIFI_IFACES[@]}"; do
    if ip link show "$iface" | grep -q "state UP"; then
        ip_addr=$(get_ip "$iface")
        if [ -n "$ip_addr" ]; then
            essid=$(iwgetid -r "$iface")
            signal=$(grep -oP 'Signal level=\K-?\d+' <(iwconfig "$iface"))
            if [ -n "$signal" ]; then
                signal_percent=$(( 2 * ($signal + 100) ))
                if (( signal_percent > 100 )); then signal_percent=100; fi
                if (( signal_percent < 0 )); then signal_percent=0; fi
            else
                signal_percent="N/A"
            fi
            echo "{\"text\":\" $essid ($signal_percent%)\",\"tooltip\":\"$iface - $essid\nIP Local: $ip_addr\nIP Pública: $public_ip\",\"class\":\"connected\"}"
            exit 0
        fi
    fi
done

# Si ninguna está conectada:
echo "{\"text\":\" Sin red\",\"class\":\"disconnected\"}"
exit 0

