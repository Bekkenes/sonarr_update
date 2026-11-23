#!/bin/bash

# Define color codes
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color

SONARR_DIR="${SONARR_DIR:-/usr/lib/sonarr/bin}"
SUDO="sudo"

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

# Work in a temporary folder that is always removed, also when something fails.
WORKDIR="$(mktemp -d)" || exit 1
trap 'rm -rf "$WORKDIR"' EXIT

# Prompt the user to input the version numbers
read -rp "Please enter the version number after v4 (e.g., 0.15.2941): " version
if [[ ! "$version" =~ ^[0-9]+(\.[0-9]+)+$ ]]; then
    print_status "failed" "'$version' is not a valid version number"
    exit 1
fi

# Download first, so Sonarr keeps running if the download fails.
# Stable releases are named Sonarr.main.*, develop builds Sonarr.develop.*.
print_status "in_progress" "Downloading Sonarr version 4.$version"
FILE=""
for branch in main develop; do
    candidate="Sonarr.$branch.4.$version.linux-x64.tar.gz"
    if wget -q -P "$WORKDIR" "https://github.com/Sonarr/Sonarr/releases/download/v4.$version/$candidate"; then
        FILE="$candidate"
        break
    fi
done
if [[ -z "$FILE" ]]; then
    print_status "failed" "Failed to download Sonarr version 4.$version (tried main and develop)"
    exit 1
fi
print_status "success" "Downloaded $FILE"

# Extract the downloaded tar.gz file
print_status "in_progress" "Extracting $FILE"
if tar -xzf "$WORKDIR/$FILE" -C "$WORKDIR" && [[ -d "$WORKDIR/Sonarr" ]]; then
    print_status "success" "Extracted $FILE"
else
    print_status "failed" "Failed to extract $FILE"
    exit 1
fi

# Stop the Sonarr service
print_status "in_progress" "Stopping the Sonarr service"
if $SUDO systemctl stop sonarr.service; then
    print_status "success" "Sonarr service stopped"
else
    print_status "failed" "Failed to stop Sonarr service"
    exit 1
fi

# Copy the extracted files to the Sonarr directory
print_status "in_progress" "Copying files to $SONARR_DIR"
if $SUDO cp -r "$WORKDIR"/Sonarr/* "$SONARR_DIR"; then
    print_status "success" "Copied files to $SONARR_DIR"
else
    print_status "failed" "Failed to copy files to $SONARR_DIR (starting Sonarr again)"
    $SUDO systemctl start sonarr.service
    exit 1
fi

# Restart the Sonarr service
print_status "in_progress" "Restarting the Sonarr service"
if $SUDO systemctl start sonarr.service; then
    print_status "success" "Sonarr service restarted"
else
    print_status "failed" "Failed to restart Sonarr service"
    exit 1
fi

# Wait for 3 seconds, then check that it is actually running
sleep 3
if systemctl is-active --quiet sonarr.service; then
    print_status "success" "Sonarr is running"
else
    print_status "failed" "Sonarr is not running – check: journalctl -u sonarr -n 50"
    exit 1
fi

echo -e "${GREEN}Update completed.${NC}"
