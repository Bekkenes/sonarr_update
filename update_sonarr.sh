#!/bin/bash

# Stop the Sonarr service
systemctl stop sonarr.service

# Prompt the user to input the version numbers
echo "Please enter the version number after v4 (e.g., 0.8.2008):"
read version

# Download the file using wget
wget https://github.com/Sonarr/Sonarr/releases/download/v4.$version/Sonarr.develop.4.$version.linux-x64.tar.gz

# Extract the downloaded tar.gz file
tar -xzf Sonarr.develop.4.$version.linux-x64.tar.gz

# Copy the extracted files to the Sonarr directory
cp -r Sonarr/* /usr/lib/sonarr/bin

# Restart the Sonarr service
systemctl start sonarr.service

# Wait for 3 seconds
sleep 3

# Clean up the downloaded and extracted files
rm -rf Sonarr Sonarr.develop.4.$version.linux-x64.tar.gz

echo "Update completed."
