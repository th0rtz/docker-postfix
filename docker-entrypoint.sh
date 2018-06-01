#!/bin/bash
#
set -euo pipefail

envs=(
	POSTFIX_HOSTNAME
	POSTFIX_MYNETWORK
	POSTFIX_PORTS
	POSTFIX_DEBUG
)

VAR_CFGMAIN="/etc/postfix/main.cf"

if [ $1 == "setup" ]; then
	echo "- Setup"
        # Configure mynetwork

        echo "-- Configuring mynetwork"
	for i in ${POSTFIX_MYNETWORK[@]};do
		echo "--- Adding network : $i"
		echo $i >> "/app/mynetwork"
	done
	VAR_MYNETWORK="\/app\/mynetwork"
	echo "-- End Mynetwork"

	#Set mailname conf
	echo "-- Setting mailname file"
	echo $POSTFIX_HOSTNAME > /etc/postfix/mailname
	echo "--- Mailname : $POSTFIX_HOSTNAME"

	#Setting up configuration

	echo "-- Modifying main.cf"
	sed -i "s/\$myhostname ESMTP \$mail_name  \(Ubuntu\)/$POSTFIX_HOSTNAME ESMTP/g" $VAR_CFGMAIN
	sed -i "s/smtpd_use_tls=yes/smtpd_use_tls=no/g" $VAR_CFGMAIN
	sed -i "s/myhostname =.*/myhostname = $POSTFIX_HOSTNAME/g" $VAR_CFGMAIN
	sed -i "s/mydestination =/\#mydestination =/g" $VAR_CFGMAIN
	sed -i "s/mynetworks =.*/mynetworks = $VAR_MYNETWORK/g" $VAR_CFGMAIN
	
	## Add more conf

	echo "-- Adding extend conf"
	echo "notify_classes=bounce" >> $VAR_CFGMAIN
	echo "always_add_missing_headers = yes" >> $VAR_CFGMAIN
	echo "local_header_rewrite_clients = static:all" >> $VAR_CFGMAIN
	echo "-- End Configuration"
fi

echo "- Start"
/etc/init.d/syslog-ng restart
/etc/init.d/postfix restart

sleep 20000000000000
