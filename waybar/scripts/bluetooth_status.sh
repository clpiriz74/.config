#!/bin/bash

powered=$(bluetoothctl show | awk '/Powered:/ {print $2}')
connected_devices=$(bluetoothctl info | grep "Connected: yes")

if [[ "$powered" != "yes" ]]; then
  echo '{"text":"","class":"off"}'
elif [[ -n "$connected_devices" ]]; then
  echo '{"text":"","class":"connected"}'
else
  echo '{"text":"","class":"on"}'
fi

