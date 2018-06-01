#!/bin/bash
#

myfile=`cat source.ip`

docker run -itd \
	-e POSTFIX_HOSTNAME=smtp.toto.fr \
	-e POSTFIX_MYNETWORK="$myfile" \
	-v $PWD/logs/:/var/log/ \
	--mount source=docker-smtp-spool,target=/var/spool/postfix \
	-p 25:25 \
	thortz/docker-postfix:dev setup
