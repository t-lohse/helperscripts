ws=$(swaymsg -t get_workspaces | jq '.. | select(.type?) | select(.focused) | .name')

swaymsg [instance="discord"] move container to workspace 10
swaymsg [class="Spotify"] move container to workspace 10
swaymsg [class="Spotify"] move right
swaymsg [class="Spotify"] resize set width 770px
swaymsg workspace $ws
