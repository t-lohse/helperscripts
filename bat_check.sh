declare -i bat=$(cat /sys/class/power_supply/BAT0/capacity)
declare -r stat=$(cat /sys/class/power_supply/BAT0/status)
if (( $bat < 6 )) && [[ "$stat" != "Charging" ]]; then
    exit 0
else
    exit 1
fi
