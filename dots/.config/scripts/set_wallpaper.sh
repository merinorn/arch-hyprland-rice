#!/usr/bin/env bash

# === CONFIG ===
WALLPAPER_DIR="$HOME/wallpapers"
SYMLINK_PATH="$HOME/.config/hypr/current_wallpaper"

mkdir -p "$WALLPAPER_DIR"

# Function to get Pictures directory
get_pictures_dir() {
  if command -v xdg-user-dir &>/dev/null; then
    xdg-user-dir PICTURES
    return
  fi

  local config_file="${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs"
  if [ -f "$config_file" ]; then
    local pictures_path
    pictures_path=$(
      source "$config_file" >/dev/null 2>&1
      echo "$XDG_PICTURES_DIR"
    )
    echo "${pictures_path/#\$HOME/$HOME}"
    return
  fi
  echo "$HOME/Pictures"
}

# Prompt for action
ACTION=$(echo -e "Select Local Wallpaper\nFetch Random Wallpaper from Konachan\nFetch Random Wallpaper from osu!" | rofi -dmenu -p "Choose action:")
if [[ -z "$ACTION" ]]; then
  exit 1
fi

case "$ACTION" in
"Select Local Wallpaper")
  # Handle spaces in filenames
  IFS=$'\n'

  SELECTED_WALL=$(for a in $(ls -t "$WALLPAPER_DIR"/*.jpg "$WALLPAPER_DIR"/*.png "$WALLPAPER_DIR"/*.gif "$WALLPAPER_DIR"/*.jpeg 2>/dev/null); do
    echo -en "$(basename "$a")\0icon\x1f$a\n"
  done | rofi -dmenu -p "Select Wallpaper:")

  [ -z "$SELECTED_WALL" ] && exit 1
  SELECTED_PATH="$WALLPAPER_DIR/$SELECTED_WALL"
  ;;

"Fetch Random Wallpaper from Konachan")
  # Fetch random wallpaper from Konachan
  page=$((1 + RANDOM % 1000))
  response=$(curl -s "https://konachan.net/post.json?tags=rating%3Asafe&limit=1&page=$page")
  link=$(echo "$response" | jq -r '.[0].file_url')

  # Validate the link
  if [ -z "$link" ]; then
    echo "Error: Unable to fetch the wallpaper link."
    exit 1
  fi

  # Determine download path
  ext=${link##*.}
  SELECTED_PATH="$WALLPAPER_DIR/random_wallpaper.$ext"

  # Download the wallpaper
  curl -s "$link" -o "$SELECTED_PATH"
  ;;

"Fetch Random Wallpaper from osu!")
  # Fetch random wallpaper from osu!
  response=$(curl -s "https://osu.ppy.sh/api/v2/seasonal-backgrounds")
  images=$(echo "$response" | jq '.backgrounds | length' -r)
  randomIndex=$((RANDOM % images))
  link=$(echo "$response" | jq ".backgrounds[$randomIndex].url" -r)

  # Validate the link
  if [ -z "$link" ]; then
    echo "Error: Unable to fetch the wallpaper link."
    exit 1
  fi

  # Determine download path
  ext=${link##*.}
  SELECTED_PATH="$WALLPAPER_DIR/random_wallpaper.$ext"

  # Download the wallpaper
  curl -s "$link" -o "$SELECTED_PATH"
  ;;

*)
  echo "Invalid action."
  exit 1
  ;;
esac

# Set the wallpaper and create/update symlink
wal -i "$SELECTED_PATH"
matugen image "$SELECTED_PATH"

# Create/update symlink for the current wallpaper
mkdir -p "$(dirname "$SYMLINK_PATH")"
ln -sf "$SELECTED_PATH" "$SYMLINK_PATH"
