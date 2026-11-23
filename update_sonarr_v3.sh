#!/bin/bash
set -e

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root." >&2
    exit 1
fi

# Check that required commands are available
for cmd in systemctl wget tar cp mktemp; do
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
read -rp "Enter version number after v4 (e.g., 0.15.2941): " version
if [[ ! "$version" =~ ^[0-9]+(\.[0-9]+)+$ ]]; then
    echo "Error: '$version' is not a valid version number." >&2
    exit 1
fi

SONARR_DIR="${SONARR_DIR:-/usr/lib/sonarr/bin}"
WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

# Download first, so Sonarr keeps running if the download fails.
# Stable releases are named Sonarr.main.*, develop builds Sonarr.develop.*.
echo "-> Downloading Sonarr version 4.$version"
FILE=""
for branch in main develop; do
    candidate="Sonarr.$branch.4.$version.linux-x64.tar.gz"
    if wget -q -P "$WORKDIR" "https://github.com/Sonarr/Sonarr/releases/download/v4.$version/$candidate"; then
        FILE="$candidate"
        break
    fi
done
if [[ -z "$FILE" ]]; then
    echo "   [FAIL] Could not download 4.$version (tried main and develop)"
    exit 1
fi
echo "   [ OK ] $FILE"

run "Extracting $FILE" tar -xzf "$WORKDIR/$FILE" -C "$WORKDIR"

run "Stopping the Sonarr service" systemctl stop sonarr.service

if ! cp -r "$WORKDIR"/Sonarr/* "$SONARR_DIR"; then
    echo "   [FAIL] Copying files to $SONARR_DIR – starting the old version again"
    systemctl start sonarr.service
    exit 1
fi
echo "-> Copied files to $SONARR_DIR"

run "Restarting the Sonarr service" systemctl start sonarr.service

sleep 3
run "Checking that Sonarr is running" systemctl is-active --quiet sonarr.service

echo "Update completed."
