#!/usr/bin/env bash

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

WALLPAPER_DIR=$(get_pictures_dir)
SYMLINK_PATH="$HOME/.config/hypr/current_wallpaper"
mkdir -p "$WALLPAPER_DIR"

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
downloadPath="$WALLPAPER_DIR/random_wallpaper.$ext"

# Download the wallpaper
curl -s "$link" -o "$downloadPath"

# Set the wallpaper
wal -i "$downloadPath"
matugen image "$downloadPath"

# Create/update symlink for the current wallpaper
mkdir -p "$(dirname "$SYMLINK_PATH")"
ln -sf "$downloadPath" "$SYMLINK_PATH"
