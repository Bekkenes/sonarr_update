Sonarr Update Script
This script automates the process of updating Sonarr to a specified version. It stops the Sonarr service, downloads the specified version, extracts the files, copies them to the appropriate directory, restarts the service, and cleans up the downloaded files. The script also provides progress updates with color-coded messages.

Prerequisites
Ensure you have wget, tar, and systemctl installed on your system.
The user running the script must have sudo privileges.
How to Use
Clone the Repository:
git clone https://github.com/yourusername/sonarr-update-script.git
cd sonarr-update-script

Make the script(s) Executable:
chmod +x update*.sh
The above command makes all scripts executable, but you can do it one by one based on filenames.

Run the Script:

Basic script
./update_sonarr.sh

Script with color:
./update_sonarr_v2.sh
Script with color for non root user:
./update_sonarr_v2_non_admin.sh

Follow the Prompts:
Enter the version number when prompted (e.g., 0.8.2008).
Script Details
The script performs the following steps:

Stops the Sonarr service.
Prompts the user to input the version number.
Downloads the specified version of Sonarr.
Extracts the downloaded file.
Copies the extracted files to the Sonarr directory.
Restarts the Sonarr service.
Waits for 3 seconds.
Cleans up the downloaded and extracted files.
Color Codes
In Progress: Yellow
Success: Green
Failed: Red
Example Output
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

License
This project is licensed under the MPL-2.0 license - see the LICENSE file for details.
