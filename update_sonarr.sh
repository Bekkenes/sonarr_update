#!/bin/bash
# Simple version. See update_sonarr_v3.sh for one with error handling.
set -e

echo "Please enter the version number after v4 (e.g., 0.15.2941):"
read -r version

WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT
cd "$WORKDIR"

# Download first (stable = main, otherwise develop), so Sonarr keeps running if it fails
wget "https://github.com/Sonarr/Sonarr/releases/download/v4.$version/Sonarr.main.4.$version.linux-x64.tar.gz" \
  || wget "https://github.com/Sonarr/Sonarr/releases/download/v4.$version/Sonarr.develop.4.$version.linux-x64.tar.gz"

tar -xzf Sonarr.*.4."$version".linux-x64.tar.gz

systemctl stop sonarr.service
cp -r Sonarr/* /usr/lib/sonarr/bin
systemctl start sonarr.service

echo "Update completed."
