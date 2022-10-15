#!/bin/env bash
time="$(timedatectl --value show | tail -1 | cut -d " " -f3)"
time=${time::-3}
if [[ $time == "13:37" ]]; then
    echo \{\"text\": \"LEET\", \"class\": \"LEET\"\}
else
    echo \{\"text\": \"$time\", \"class\": \"good\"\}
fi
