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

# Install web server (Nginx)
echo "Step 4: Installing Nginx web server..."
pause
sudo apt install -y nginx
if [ $? -eq 0 ]; then
  echo "Nginx installed successfully." >> $LOGFILE
else
  echo "Failed to install Nginx." >> $LOGFILE
fi

# Install database server (MySQL or PostgreSQL)
echo "Step 5: Installing database server..."
pause
read -p "Do you want to install MySQL or PostgreSQL? (mysql/postgresql): " db_choice
if [ "$db_choice" == "mysql" ]; then
  sudo apt install -y mysql-server
  if [ $? -eq 0 ]; then
    echo "MySQL installed successfully." >> $LOGFILE
  else
    echo "Failed to install MySQL." >> $LOGFILE
  fi
elif [ "$db_choice" == "postgresql" ]; then
  sudo apt install -y postgresql postgresql-contrib
  if [ $? -eq 0 ]; then
    echo "PostgreSQL installed successfully." >> $LOGFILE
  else
    echo "Failed to install PostgreSQL." >> $LOGFILE
  fi
else
  echo "No database server installed." >> $LOGFILE
fi

# Install PHP and additional modules
echo "Step 6: Installing PHP..."
pause
sudo apt install -y php php-cli php-fpm php-mysql php-pgsql
if [ $? -eq 0 ]; then
  echo "PHP installed successfully." >> $LOGFILE
else
  echo "Failed to install PHP." >> $LOGFILE
fi

# Configure storage directory
echo "Step 7: Configuring storage directory..."
pause
read -p "Enter the directory path for storage (e.g., /var/storage): " storage_dir
sudo mkdir -p "$storage_dir"
sudo chown -R $USER:$USER "$storage_dir"
if [ $? -eq 0 ]; then
  echo "Storage directory configured at $storage_dir." >> $LOGFILE
else
  echo "Failed to configure storage directory." >> $LOGFILE
fi

# Summary of results
echo "Setup process completed. Here's the summary of results:"
cat $LOGFILE
