#!/usr/bin/env bash

# Function to get the default Pictures directory
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

# Directory setup
PICTURES_DIR=$(get_pictures_dir)
mkdir -p "$PICTURES_DIR/Wallpapers"
page=$((1 + RANDOM % 1000))

# Get a random wallpaper from Konachan
response=$(curl -s "https://konachan.net/post.json?tags=rating%3Asafe&limit=1&page=$page")
link=$(echo "$response" | jq -r '.[0].file_url')
ext=${link##*.} # Get the file extension

downloadPath="$PICTURES_DIR/Wallpapers/random_wallpaper.$ext"

# Download the wallpaper
curl -s "$link" -o "$downloadPath"

# Set the wallpaper using swww
# swww img "$downloadPath" --transition-type any # --transition-fps 60
wal -i "$downloadPath"
matugen image "$downloadPath"
