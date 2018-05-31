#!/bin/bash
#
set -euo pipefail

envs=(
	POSTFIX_HOSTNAME
	POSTFIX_PORTS
	POSTFIX_DEBUG
)

VAR_CFGMAIN="/etc/postfix/main.cf"
VAR_MYNETWORK="\/app\/mynetwork"

if [ $1 == "setup" ]; then

	#Set mailname conf
	echo "-- Setting mailname file"
	echo $POSTFIX_HOSTNAME > /etc/postfix/mailname

	#Setting up configuration

	echo "-- Modifying main.cf"
	sed -i "s/\$myhostname ESMTP \$mail_name (Ubuntu)/$POSTFIX_HOSTNAME ESMTP/g" $VAR_CFGMAIN
	sed -i "s/smtpd_use_tls=yes/smtpd_use_tls=no/g" $VAR_CFGMAIN
	sed -i "s/myhostname =.*/myhostname = $POSTFIX_HOSTNAME/g" $VAR_CFGMAIN
	sed -i "s/mydestination =/\#mydestination =/g" $VAR_CFGMAIN
	sed -i "s/mynetworks =/mynetworks = $VAR_MYNETWORK/g" $VAR_CFGMAIN
	
	## Add more conf

	echo "-- Adding extend conf"
	echo "notify_classes=bounce" >> $VAR_CFGMAIN
	echo "always_add_missing_headers = yes" >> $VAR_CFGMAIN
	echo "local_header_rewrite_clients = static:all" >> $VAR_CFGMAIN
fi

if [ $1 == "reload" ]; then
	service postfix reload
fi


sleep 20000000000000
