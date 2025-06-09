#!/bin/bash
# Enhanced media control with all players + actions

players=$(playerctl -l 2>/dev/null)

if [ -z "$players" ]; then
  notify-send "No Media Players" "No MPRIS-compatible players found"
  exit 1
fi

# Sort players with Spotify at the top
# sorted_players=$(
#   echo "$players" | grep -E "^spotify"
#   echo "$players" | grep -v -E "^spotify"
# )

sorted_players=$(
  echo "$players" | grep -E "^spotify"
  echo "$players" | grep -v -E "^spotify"
)
# Build menu with players first, then global actions
menu=""
while IFS= read -r player; do
  [ -n "$player" ] && menu+="🎵 $player\n"
done <<<"$sorted_players"
menu+="⏸️  Pause All\n⏯️  Play/Pause All" #\n⏭️  Next All\n⏮️  Previous All"

choice=$(echo -e "$menu" | rofi -dmenu -p "Media Control:")

case "$choice" in
🎵\ *)
  # Extract player name (remove emoji and space)
  player="${choice#🎵 }"
  playerctl --player="$player" shift
  playerctl -p "$player" play-pause
  echo "$player" >~/.cache/rofi-media-player
  notify-send "Media Control" "Play/Pause: $player"
  ;;
"⏸️  Pause All")
  playerctl -a pause
  ;;
"⏯️  Play/Pause All")
  playerctl -a play-pause
  ;;
"⏭️  Next All")
  playerctl -a next
  ;;
"⏮️  Previous All")
  playerctl -a previous
  ;;
esac
