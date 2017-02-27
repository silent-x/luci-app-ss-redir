#!/bin/sh
#bc:14:ef:a5:08:8f      hi-media
#34:ab:37:61:3d:41      ipad-air2
#00:66:cf:0e:5b:14      hi-media-lan
#echo $1
#echo $2
#time is in UTC
if [ "$1" = 'on' ]; then
        echo "turn on internet $2"
        mac=`echo $2|awk '{print toupper($0)}'`
        #echo $mac
        linenum=`iptables -L FORWARD --line-number|grep $mac|cut -d ' ' -f 1|head -1`
        if [ -n "$linenum" ]; then
                iptables -D FORWARD $linenum
        fi 
        #iptables -D FORWARD -j REJECT -m mac --mac-source $2 -m time --timestart 16:00 --timestop 23:30 #-j DROP
else if [ "$1" = 'off' ]; then
        echo "turn off internet $2"
        iptables -I FORWARD -j REJECT -m mac --mac-source $2 -m time --timestart 16:00 --timestop 23:30 #-j DROP
     else
        iptables --list FORWARD
        echo "==============================================="
        echo "bc:14:ef:a5:08:8f      hi-media"
        echo "34:ab:37:61:3d:41      ipad-air2"
        echo "00:66:cf:0e:5b:14      hi-media-lan"
     fi
fi