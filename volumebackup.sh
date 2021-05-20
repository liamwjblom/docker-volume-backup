now=$(date +'%m-%d-%Y')
nowtime=$(date):

if [ -z "$1" ]
then
        echo $nowtime "PLEASE SPECIFY CONTAINER NAME!!! Exiting..."
        exit
else
        echo
fi

name=$(echo $1| sed -e "s/\b\(.\)/\u\1/g")

cd /home/wjblom
Stop=$(/snap/bin/docker stop $1)

if [ $Stop = $1 ]
then
        echo $nowtime "Starting $name container volume Backup..."
	sleep 2
	echo $nowtime $name "container stopped"
else
        echo $nowtime "ERROR"
	echo "Exiting..."
	exit
fi

sleep 2

cd /var/snap/docker/common/var-lib-docker/volumes/$1/
echo $nowtime "Zipping files to /home/wjblom/backup/Docker/$name/$1$now.zip"
zipping=$(zip -r /home/wjblom/backup/Docker/$name/$1$now.zip * >> /home/wjblom/backup/Scripts/logs/$1$now.txt)

ZipSize=$(wc -c /home/wjblom/backup/Docker/$name/$1$now.zip)
BetterZipSize=$(echo "${ZipSize}" | awk '{ split( "B KB MB GB TB PB" , v ); s=1; while( $1>1024 ){ $1/=1024; s++ } printf "%.2f %s", $1, v[s] }')
echo $nowtime "ZIP complete:" $BetterZipSize"!"
echo $nowtime "ZIP output saved to /home/wjblom/backup/Scripts/logs/$name$now.txt"

sleep 2

cd /home/wjblom
Start=$(/snap/bin/docker start $1)

if [ $Start = "$1" ]
then
        echo $nowtime $name "container restarted successfully"
else
        echo $nowtime "ERROR: Failed to restart $name container"
        echo "Exiting..."
        exit
fi

echo $nowtime $name "Backup Complete ;D"
