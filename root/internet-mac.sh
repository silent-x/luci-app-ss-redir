#!/bin/sh
#bc:14:ef:a5:08:8f      hi-media
#34:ab:37:61:3d:41      ipad-air2
#00:66:cf:0e:5b:14      hi-media-lan
#echo $1
#echo $2
#time is in UTC
if [ "$1" = 'on' ]; then
        echo "turn on internet $2"
        iptables -D FORWARD -m mac --mac-source $2 -m time --timestart 16:00 --timestop 23:30 -j DROP
else 
        echo "turn off internet $2"
        iptables -I FORWARD -m mac --mac-source $2 -m time --timestart 16:00 --timestop 23:30 -j DROP
fi