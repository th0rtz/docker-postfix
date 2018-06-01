#!/bin/bash
#

mydate=`date +%Y%m%d%H%M`
mydocker=`docker ps -a -f "status=running" |grep docker-postfix|awk {'print $1'}`

echo "[$mydate] - Starting update of postfix"
echo "[$mydate] - pulling latest image of docker-postfix"
docker pull thortz/docker-postfix:latest
echo "[$mydate] - Killing running docker ID"
docker kill $ $mydocker
echo "[$mydate] - Removing docker ID"
docker rm $mydocker
echo "[$mydate] - Starting the new image"
./start-with-file.sh
echo "[$mydate] - End of upgrade"
echo ""
