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

# Get random seasonal background from osu!
response=$(curl -s "https://osu.ppy.sh/api/v2/seasonal-backgrounds")
images=$(echo "$response" | jq '.backgrounds | length' -r)
randomIndex=$((RANDOM % images))
link=$(echo "$response" | jq ".backgrounds[$randomIndex].url" -r)

# Check if the link is valid
if [ -z "$link" ]; then
  echo "Error: Unable to fetch the wallpaper link."
  exit 1
fi

# Determine the file extension and download path
ext=${link##*.}
downloadPath="$PICTURES_DIR/Wallpapers/random_wallpaper.$ext"

# Download the wallpaper
curl -s "$link" -o "$downloadPath"

# Set the wallpaper using swww
# swww img "$downloadPath" --transition-type any
wal -i "$downloadPath"
matugen image "$downloadPath"
