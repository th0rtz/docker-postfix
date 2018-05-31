FROM thortz/docker-xenial

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y postfix

RUN apt-get install -y syslog-ng logrotate

ADD /app/mynetwork /app/mynetwork
ADD docker-entrypoint.sh docker-entrypoint.sh

EXPOSE 25

ENTRYPOINT ["./docker-entrypoint.sh"]
