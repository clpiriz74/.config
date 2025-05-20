#!/bin/bash

updates=$(checkupdates-with-aur 2>/dev/null | wc -l)

if [ "$updates" -eq 0 ]; then
    echo '{"text": " 0", "class": "clean"}'
else
    echo "{\"text\": \" $updates\", \"class\": \"updates\"}"
fi

