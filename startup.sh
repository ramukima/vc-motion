#!/bin/bash

if [ ! -f /home/nobody/motioneye/conf/.bootstrapped_motion ]
then
	if [ ! -d /config ]; then
        	mkdir -p /config
	fi

	# Check for motion.conf config file
	if [ ! -f /config/motion.conf ]; then
        	cp /etc/motion/motion.conf /config/motion.conf
	fi

	if [ ! -d /home/nobody/motioneye/conf ]; then
        	mkdir -p /home/nobody/motioneye/{conf,log,run,media}
        	chown -R nobody:users /home/nobody
        	chmod -R 775 /home/nobody
        	ln -sf /config/motion.conf /home/nobody/motioneye/conf/motion.conf
        	ln -sf /config/motioneye.conf /home/nobody/motioneye/conf/motioneye.conf
	fi

	PUID=${PUID:-99}
	PGID=${PGID:-100}

	if [ ! "$(id -u nobody)" -eq "$PUID" ]; then usermod -o -u "$PUID" nobody ; fi
	if [ ! "$(id -g nobody)" -eq "$PGID" ]; then groupmod -o -g "$PGID" users ; fi

	# Set permissions on the config directory
	echo "Fixing permissions"
	chown -R nobody:users /config /home/nobody/motioneye/media
	chmod -R 775 /config
	echo 1 > /home/nobody/motioneye/conf/.bootstrapped_motion
fi

while(true)
do
	sudo -u nobody motion -c /home/nobody/motioneye/conf/motion.conf
	sleep 5
done
