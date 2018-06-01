# docker-postfix

> docker run -itd \
	-e POSTFIX_HOSTNAME=smtp.toto.fr \
	-e POSTFIX_MYNETWORK="192.168.1.0/24 172.16.16.0/16" \
	-v $PWD/logs/:/var/log/ \
	--mount source=docker-smtp-spool,target=/var/spool/postfix \
	-p 25:25 \
	thortz/docker-postfix:dev setup

- POSTFIX_HOSTNAME : specify the hostname of the smtp server.
- POSTFIX_MYNETWORK : Add network or host separate by space.


- start-with-file.sh : start the container with the file "source.ip" load for POSTFIX_MYNETWORK
- update-docker.sh : autoupdate container
