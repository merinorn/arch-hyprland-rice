#!/usr/bin/env bash

# Bar Switcher Script
# Switches between different Waybar configurations

WAYBAR_CONFIG="$HOME/.config/waybar"
WAYBAR_CONFIG_DIR="$HOME/.config/waybar/configs"
ROFI_CONFIG="$HOME/.config/rofi/config.rasi"

# Function to switch to top bar
switch_to_top() {
  top config and style
  cp "$WAYBAR_CONFIG_DIR/topconfig.jsonc" "$WAYBAR_CONFIG/config.jsonc"
  cp "$WAYBAR_CONFIG_DIR/topstyle.css" "$WAYBAR_CONFIG/style.css"
  
  # Reload waybar
  pkill waybar
  sleep 0.2
  waybar &
  
  notify-send "Waybar" "Switched to top bar"
}

# Function to switch to bottom bar
switch_to_bottom() {
  cp "$WAYBAR_CONFIG_DIR/bottomconfig.jsonc" "$WAYBAR_CONFIG/config.jsonc"
  cp "$WAYBAR_CONFIG_DIR/bottomstyle.css" "$WAYBAR_CONFIG/style.css"
  
  # Reload waybar
  pkill waybar
  sleep 0.2
  waybar &
  
  notify-send "Waybar" "Switched to bottom bar"
}

# Function to switch to elifouts bar
switch_to_elifouts() {
  cp "$WAYBAR_CONFIG_DIR/elifoutsconfig.jsonc" "$WAYBAR_CONFIG/config.jsonc"
  cp "$WAYBAR_CONFIG_DIR/elifoutsstyle.css" "$WAYBAR_CONFIG/style.css"
  
  # Reload waybar
  pkill waybar
  sleep 0.2
  waybar &
  
  notify-send "Waybar" "Switched to elifouts bar"
}

# Function to switch to my bar
switch_to_my() {
  cp "$WAYBAR_CONFIG_DIR/myconfig.jsonc" "$WAYBAR_CONFIG/config.jsonc"
  cp "$WAYBAR_CONFIG_DIR/mystyle.css" "$WAYBAR_CONFIG/style.css"
  
  # Reload waybar
  pkill waybar
  sleep 0.2
  waybar &
  
  notify-send "Waybar" "Switched to elifouts bar"
}

# Function to switch to bentag bar
switch_to_bentag() {
  cp "$WAYBAR_CONFIG_DIR/bentagconfig.jsonc" "$WAYBAR_CONFIG/config.jsonc"
  cp "$WAYBAR_CONFIG_DIR/bentagstyle.css" "$WAYBAR_CONFIG/style.css"
  
  # Reload waybar
  pkill waybar
  sleep 0.2
  waybar &
  
  notify-send "Waybar" "Switched to bentag bar"
}

switch_to_macOS() {
  cp "$WAYBAR_CONFIG_DIR/macOSgconfig.jsonc" "$WAYBAR_CONFIG/config.jsonc"
  cp "$WAYBAR_CONFIG_DIR/macOSstyle.css" "$WAYBAR_CONFIG/style.css"
  
  # Reload waybar
  pkill waybar
  sleep 0.2
  waybar &
  
  notify-send "Waybar" "Switched to macOS bar"
}

switch_to_simple() {
  cp "$WAYBAR_CONFIG_DIR/simpleconfig.jsonc" "$WAYBAR_CONFIG/config.jsonc"
  cp "$WAYBAR_CONFIG_DIR/simplestyle.css" "$WAYBAR_CONFIG/style.css"
  
  # Reload waybar
  pkill waybar
  sleep 0.2
  waybar &
  
  notify-send "Waybar" "Switched to simple bar"
}

switch_to_vertical() {
  cp "$WAYBAR_CONFIG_DIR/verticalconfig.jsonc" "$WAYBAR_CONFIG/config.jsonc"
  cp "$WAYBAR_CONFIG_DIR/verticalstyle.css" "$WAYBAR_CONFIG/style.css"
  
  # Reload waybar
  pkill waybar
  sleep 0.2
  waybar &
  
  notify-send "Waybar" "Switched to vertical bar"
}


# Main menu
selected=$(echo -e "Top\nBottom\nElifouts\nMy\nBentag\nMacOS\nSimple\nVertical" | rofi -dmenu -i -p "Bar Position" -theme "$ROFI_CONFIG")

case "$selected" in
  "Top") switch_to_top ;;
  "Bottom") switch_to_bottom ;;
  "Elifouts") switch_to_elifouts ;;
  "My") switch_to_my ;;
  "Bentag") switch_to_bentag ;;
  "MacOS") switch_to_macOS ;;
  "Simple") switch_to_simple ;;
  "Vertical") switch_to_vertical ;;
esac