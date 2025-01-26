#!/bin/bash

# Summary log file
LOGFILE="ssh_setup_summary.log"
echo "SSH Server Setup Summary - $(date)" > $LOGFILE

# Function to pause before steps
pause() {
  read -p "Press Enter to continue..."
}

# Step 1: Update and upgrade packages
echo "Step 1: Updating system packages..."
pause
sudo apt update && sudo apt upgrade -y
if [ $? -eq 0 ]; then
  echo "System packages updated successfully." >> $LOGFILE
else
  echo "Failed to update system packages." >> $LOGFILE
  exit 1
fi

# Step 2: Install OpenSSH Server
echo "Step 2: Installing OpenSSH server..."
pause
sudo apt install -y openssh-server
if [ $? -eq 0 ]; then
  echo "OpenSSH server installed successfully." >> $LOGFILE
else
  echo "Failed to install OpenSSH server." >> $LOGFILE
  exit 1
fi

# Step 3: Enable and start the SSH service
echo "Step 3: Enabling and starting SSH service..."
pause
sudo systemctl enable ssh
sudo systemctl start ssh
if [ $? -eq 0 ]; then
  echo "SSH service enabled and started successfully." >> $LOGFILE
else
  echo "Failed to enable or start SSH service." >> $LOGFILE
  exit 1
fi

# Step 4: Configure UFW to allow SSH
echo "Step 4: Configuring firewall to allow SSH connections..."
pause
sudo ufw allow ssh
sudo ufw enable
if [ $? -eq 0 ]; then
  echo "Firewall configured to allow SSH connections." >> $LOGFILE
else
  echo "Failed to configure firewall for SSH." >> $LOGFILE
fi

# Final Summary
echo "SSH server setup process completed. Here's the summary of results:"
cat $LOGFILE
#copy ssh pub key to server ------ To Do not complete ----