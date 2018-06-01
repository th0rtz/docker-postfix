FROM thortz/docker-xenial

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y postfix

RUN apt-get install -y syslog-ng logrotate

RUN sed -i -E 's/^(\s*)system\(\);/\1unix-stream("\/dev\/log");/' /etc/syslog-ng/syslog-ng.conf
RUN sed -i 's/^#\(SYSLOGNG_OPTS="--no-caps"\)/\1/g' /etc/default/syslog-ng

ADD /app/mynetwork /app/mynetwork
ADD docker-entrypoint.sh docker-entrypoint.sh

EXPOSE 25

ENTRYPOINT ["./docker-entrypoint.sh"]
