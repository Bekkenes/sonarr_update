#!/bin/bash

# Define color codes
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color

# Function to print status
print_status() {
    local status=$1
    local message=$2
    case $status in
        "in_progress")
            echo -e "${YELLOW}In progress: ${message}${NC}"
            ;;
        "success")
            echo -e "${GREEN}Success: ${message}${NC}"
            ;;
        "failed")
            echo -e "${RED}Failed: ${message}${NC}"
            ;;
    esac
}

# Stop the Sonarr service
print_status "in_progress" "Stopping the Sonarr service"
if systemctl stop sonarr.service; then
    print_status "success" "Sonarr service stopped"
else
    print_status "failed" "Failed to stop Sonarr service"
    exit 1
fi

# Prompt the user to input the version numbers
echo "Please enter the version number after v4 (e.g., 0.8.2008):"
read version

# Download the file using wget
print_status "in_progress" "Downloading Sonarr version 4.$version"
if wget https://github.com/Sonarr/Sonarr/releases/download/v4.$version/Sonarr.develop.4.$version.linux-x64.tar.gz; then
    print_status "success" "Downloaded Sonarr version 4.$version"
else
    print_status "failed" "Failed to download Sonarr version 4.$version"
    exit 1
fi

# Extract the downloaded tar.gz file
print_status "in_progress" "Extracting Sonarr.develop.4.$version.linux-x64.tar.gz"
if tar -xzf Sonarr.develop.4.$version.linux-x64.tar.gz; then
    print_status "success" "Extracted Sonarr.develop.4.$version.linux-x64.tar.gz"
else
    print_status "failed" "Failed to extract Sonarr.develop.4.$version.linux-x64.tar.gz"
    exit 1
fi

# Copy the extracted files to the Sonarr directory
print_status "in_progress" "Copying files to /usr/lib/sonarr/bin"
if cp -r Sonarr/* /usr/lib/sonarr/bin; then
    print_status "success" "Copied files to /usr/lib/sonarr/bin"
else
    print_status "failed" "Failed to copy files to /usr/lib/sonarr/bin"
    exit 1
fi

# Restart the Sonarr service
print_status "in_progress" "Restarting the Sonarr service"
if systemctl start sonarr.service; then
    print_status "success" "Sonarr service restarted"
else
    print_status "failed" "Failed to restart Sonarr service"
    exit 1
fi

# Wait for 3 seconds
print_status "in_progress" "Waiting for 3 seconds"
sleep 3
print_status "success" "Waited for 3 seconds"

# Clean up the downloaded and extracted files
print_status "in_progress" "Cleaning up files"
if rm -rf Sonarr Sonarr.develop.4.$version.linux-x64.tar.gz; then
    print_status "success" "Cleaned up files"
else
    print_status "failed" "Failed to clean up files"
    exit 1
fi

echo -e "${GREEN}Update completed.${NC}"
