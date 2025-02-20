#!/bin/bash
set -e

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root." >&2
    exit 1
fi

# Check that required commands are available
for cmd in systemctl wget tar cp rm; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: Required command '$cmd' is not installed." >&2
        exit 1
    fi
done

# Function to execute a command with a status message
run() {
    local msg="$1"
    shift
    echo "-> $msg"
    if "$@"; then
        echo "   [ OK ]"
    else
        echo "   [FAIL] $msg"
        exit 1
    fi
}

# Prompt for version number
read -rp "Enter version number after v4 (e.g., 0.8.2008): " version
FILE="Sonarr.develop.4.$version.linux-x64.tar.gz"

run "Stopping the Sonarr service" systemctl stop sonarr.service

run "Downloading Sonarr version 4.$version" wget "https://github.com/Sonarr/Sonarr/releases/download/v4.$version/$FILE"

run "Extracting $FILE" tar -xzf "$FILE"

run "Copying files to /usr/lib/sonarr/bin" cp -r Sonarr/* /usr/lib/sonarr/bin

run "Restarting the Sonarr service" systemctl start sonarr.service

echo "Waiting for 3 seconds..."
sleep 3

run "Cleaning up downloaded and extracted files" rm -rf Sonarr "$FILE"

echo "Update completed."
