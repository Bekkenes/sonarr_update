# sonarr_update
Simple bashscript for updating sonarr.
There are many ways of doing it, but i wrote a simple script to update my own lxc container.

What it does it as follows:
1) it will stop the sonarr service.
2) you will be prompted to imput the version number (ie, if version showing in webgui is 4.0.8.2008, you enter 0.8.2008. It will then wget the file.
3) it will unpack it into a Sonarr folder in the scripts folder.
4) The downloaded file and the scripts Sonarr folder will be removed.
5) The sonarr service will be started again
6) 
