#!/bin/bash
#

myfile=`cat source.ip`

docker run -itd \
	-e POSTFIX_HOSTNAME=smtp.toto.fr \
	-e POSTFIX_MYNETWORK="$myfile" \
	-v /home/postfix/logs/mail.log:/var/log/mail.log \
	--mount source=docker-smtp-spool,target=/var/spool/postfix \
	-p 25:25 \
	thortz/docker-postfix:dev setup
