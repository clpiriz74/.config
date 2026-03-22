#!/bin/bash

capacity=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

# Escoge ícono según el porcentaje
if [ "$capacity" -le 20 ]; then
    icon="󰁻"
    class="low"
elif [ "$capacity" -le 40 ]; then
    icon="󰁽"
    class="medium"
elif [ "$capacity" -le 60 ]; then
    icon="󰁿"
    class="medium"
elif [ "$capacity" -le 80 ]; then
    icon="󰂁"
    class="normal"
else
    icon="󰁹"
    class="normal"
fi

# Si está cargando, sobrescribe la clase
if [ "$status" = "Charging" ]; then
    icon="󰂄" 
    class="charging"
fi

echo "{\"text\": \"$icon$capacity%\", \"class\": \"$class\", \"tooltip\": \"Battery: $status\"}"

