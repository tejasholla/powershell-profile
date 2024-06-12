#!/bin/bash

# Function to remove empty files and directories with permission checks
clean_empty_files() {
  sudo find "$1" -type f -empty -exec rm -f {} + 2>/dev/null
  sudo find "$1" -type d -empty -exec rmdir {} + 2>/dev/null
}

# Suppress login messages
touch ~/.hushlogin

# Update package list silently
sudo apt update > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo -e "\033[1;31mFailed to update package list. Please check your internet connection or package manager configuration.\033[0m"
  exit 1
fi

# Clean up storage by removing unused packages
sudo apt autoremove -y > /dev/null 2>&1

# Clean up cache memory
sudo apt clean > /dev/null 2>&1

# Remove unwanted files (e.g., temporary files)
sudo rm -rf /tmp/* /var/tmp/* > /dev/null 2>&1

# Remove empty files and directories from the entire WSL folder, excluding problematic areas
clean_empty_files "/home"
clean_empty_files "/root"

echo -e "\033[1;32mCleaned autoremove,clean,unwanted,home and root\033[0m"

# Check for available updates
UPDATES=$(apt list --upgradable 2>/dev/null | grep -v "Listing..." | wc -l)

if [ "$UPDATES" -gt 0 ]; then
  # Upgrade installed packages silently
  sudo apt upgrade -y > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo -e "\033[1;31mFailed to upgrade packages. Please check for errors.\033[0m"
    exit 1
  fi

  echo -e "\033[1;32mSystem upgraded successfully.\033[0m"
else
  echo -e "\033[1;32mSystem is already up to date.\033[0m"
fi

# Install desired packages silently
sudo apt install -y nala btop screen > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo -e "\033[1;31mFailed to install packages. Please check for errors.\033[0m"
  exit 1
fi

# Clear the terminal screen
clear

# Display IP address and hostname
IP_ADDRESS=$(hostname -I | awk '{print $1}')
HOSTNAME=$(hostname)

# Calculate lengths for table formatting
FIELD_WIDTH=12
VALUE_WIDTH=$(echo -e "$IP_ADDRESS\n$HOSTNAME" | awk '{ if (length > x) x = length } END { print x }')
TABLE_WIDTH=$((FIELD_WIDTH + VALUE_WIDTH + 5))

# Create the table
printf "\033[1;34m+%s+\033[0m\n" "$(printf "%-${TABLE_WIDTH}s" | tr ' ' '-')"
printf "\033[1;34m| %-*s | %-*s |\033[0m\n" $FIELD_WIDTH "Field" $VALUE_WIDTH "Value"
printf "\033[1;34m+%s+\033[0m\n" "$(printf "%-${TABLE_WIDTH}s" | tr ' ' '-')"
printf "\033[1;34m| %-*s | \033[0m%-*s\033[1;34m |\033[0m\n" $FIELD_WIDTH "IP Address" $VALUE_WIDTH "$IP_ADDRESS"
printf "\033[1;34m| %-*s | \033[0m%-*s\033[1;34m |\033[0m\n" $FIELD_WIDTH "Hostname" $VALUE_WIDTH "$HOSTNAME"
printf "\033[1;34m+%s+\033[0m\n" "$(printf "%-${TABLE_WIDTH}s" | tr ' ' '-')"
