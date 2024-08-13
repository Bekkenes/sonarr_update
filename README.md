# Sonarr Update Script

This script automates the process of updating Sonarr to a specified version. It stops the Sonarr service, downloads the specified version, extracts the files, copies them to the appropriate directory, restarts the service, and cleans up the downloaded files. The script also provides progress updates with color-coded messages.

## Prerequisites

- Ensure you have `wget`, `tar`, and `systemctl` installed on your system.
- The user running the script must have `sudo` privileges.

## How to Use

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/sonarr-update-script.git
   cd sonarr-update-script
   ```

2. **Make the Scripts Executable:**

   ```bash
   chmod +x update_sonarr*.sh
   ```

3. **Run the Script (choose your version, under is script with color and no root):**

   ```bash
   ./update_sonarr_v2_non_admin.sh
   ```

4. **Follow the Prompts:**

   - Enter the version number when prompted (e.g., `0.8.2008`).

## Script Details

The script performs the following steps:

1. Stops the Sonarr service.
2. Prompts the user to input the version number.
3. Downloads the specified version of Sonarr.
4. Extracts the downloaded file.
5. Copies the extracted files to the Sonarr directory.
6. Restarts the Sonarr service.
7. Waits for 3 seconds.
8. Cleans up the downloaded and extracted files.

## Color Codes

- **In Progress:** Yellow
- **Success:** Green
- **Failed:** Red

## Example Output

```bash
In progress: Stopping the Sonarr service
Success: Sonarr service stopped
In progress: Downloading Sonarr version 4.0.8.2008
Success: Downloaded Sonarr version 4.0.8.2008
In progress: Extracting Sonarr.develop.4.0.8.2008.linux-x64.tar.gz
Success: Extracted Sonarr.develop.4.0.8.2008.linux-x64.tar.gz
In progress: Copying files to /usr/lib/sonarr/bin
Success: Copied files to /usr/lib/sonarr/bin
In progress: Restarting the Sonarr service
Success: Sonarr service restarted
In progress: Waiting for 3 seconds
Success: Waited for 3 seconds
In progress: Cleaning up files
Success: Cleaned up files
Update completed.
```

## License

This project is licensed under the MPL-2.0 license - see the [LICENSE](LICENSE) file for details.

---

Feel free to customize the README further to suit your needs!
