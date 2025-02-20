# Sonarr Update Script (Manual Version)

This Bash script updates Sonarr by downloading a specified release version from GitHub, extracting it, and updating the installation directory. It is designed to be simple with minimal CLI output.

## Features

- **Root Check:** Ensures the script is run as root.
- **Prerequisite Validation:** Checks for required commands (`systemctl`, `wget`, `tar`, `cp`, `rm`).
- **User Input:** Prompts the user for a version number (formatted as `0.8.2008` corresponding to `v4.0.8.2008`).
- **Service Management:** Stops the Sonarr service before the update and restarts it afterward.
- **Download & Extraction:** Downloads the specified tarball from GitHub and extracts it.
- **File Deployment:** Copies the new files to the Sonarr installation directory.
- **Cleanup:** Removes temporary files after the update.

## Prerequisites

- Bash shell
- Root privileges (or run with `sudo`)
- The following commands must be installed:
  - `systemctl`
  - `wget`
  - `tar`
  - `cp`
  - `rm`
- GitHub release files should follow the naming convention:  
  `Sonarr.develop.4.<version>.linux-x64.tar.gz`

## Usage

1. **Make the script executable:**

   ```bash
   chmod +x update_sonarr_v3.sh

2. **run the script:**

   ```bash
   ,/update_sonarr_v3.sh
3. **Enter version number:**

When prompted, enter the version number (e.g., `0.8.2008`). This corresponds to the GitHub tag `v4.0.8.2008`.

## Script Execution Steps

The script will then execute the following steps:

- **Stop the Sonarr service.**
- **Download the specified version from GitHub.**
- **Extract the downloaded tarball.**
- **Copy the files to `/usr/lib/sonarr/bin`.**
- **Restart the Sonarr service.**
- **Clean up the downloaded and extracted files.**

## Disclaimer

Use this script at your own risk. Always back up your configuration and data before performing any updates.
