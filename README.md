# docker-volume-backup
sh Script to backup your docker volumes by stopping the container zipping to /home/"username"/backup and restarting container

Edit script for your correct paths, mine setup as follow:

/home/wjblom/backup/Scripts - Where the script is stored
/home/wjblom/backup/Scripts/logs - for ZIP output log
/home/wjblom/backup/Docker/CONTAINERNAME - to store ZIP backup

!!!NOTE - Dockername and volume name must be the same!!!

to run use ./volumebackup.sh CONTAINERNAME e.g. ./volumebackup.sh homeassistant


