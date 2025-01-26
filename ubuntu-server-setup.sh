#!/bin/bash

# Summary log file
LOGFILE="setup_summary.log"
echo "Server Setup Summary - $(date)" > $LOGFILE

# Function to pause before each step
pause() {
  read -p "Press Enter to continue..."
}

# Update and upgrade system packages
echo "Step 1: Updating system packages..."
pause
sudo apt update && sudo apt upgrade -y
if [ $? -eq 0 ]; then
  echo "System packages updated successfully." >> $LOGFILE
else
  echo "Failed to update system packages." >> $LOGFILE
fi

# Install essential tools
echo "Step 2: Installing essential tools (curl, wget, git, etc.)..."
pause
sudo apt install -y curl wget git unzip zip software-properties-common
if [ $? -eq 0 ]; then
  echo "Essential tools installed successfully." >> $LOGFILE
else
  echo "Failed to install essential tools." >> $LOGFILE
fi

# Set up a firewall (UFW)
echo "Step 3: Setting up UFW firewall..."
pause
sudo apt install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw enable
if [ $? -eq 0 ]; then
  echo "Firewall configured successfully." >> $LOGFILE
else
  echo "Failed to configure firewall." >> $LOGFILE
fi

# Summary of results
echo "Setup process completed. Here's the summary of results:"
cat $LOGFILE
