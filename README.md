# sonarr_update
Simple bashscript for updating sonarr.
There are many ways of doing it, but i wrote a simple script to update my own lxc container.

What it does it as follows:
1) Stops the sonarr service.
2) Prompts you to input the version number (ie, if version showing in webgui is 4.0.8.2008, you enter 0.8.2008.
3) Wgets the file.
4) Unpacks file it into a Sonarr folder in the scripts folder.
5) The sonarr service will be started again
6) The downloaded file and the scripts Sonarr folder will be removed.

#How to run
Make the script executable by running chmod +x update_sonarr.sh.
Execute the script by running ./update_sonarr.sh.
