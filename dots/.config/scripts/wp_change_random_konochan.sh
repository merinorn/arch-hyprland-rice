#!/usr/bin/env bash

# === CONFIG ===
WALLPAPER_DIR="$HOME/wallpapers"
SYMLINK_PATH="$HOME/.config/hypr/current_wallpaper"

mkdir -p "$WALLPAPER_DIR"

# === FETCH RANDOM WALLPAPER FROM KONACHAN ===
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

# Set the wallpaper
wal -i "$SELECTED_PATH"
matugen image "$SELECTED_PATH"

# Create/update symlink for the current wallpaper
mkdir -p "$(dirname "$SYMLINK_PATH")"
ln -sf "$SELECTED_PATH" "$SYMLINK_PATH"

# === SHOW CURRENT WALLPAPER IN ROFI ===
# rofi -show file -file "$SELECTED_PATH" -message "Current Wallpaper"
