#!/bin/sh
ddnsname=silent-x.ddns.net
waninterface=pppoe-wan
ddnswanip=`ping $ddnsname -s1 -c1 | grep $ddnsname | head -n1 | cut -d'(' -f2 | cut -d')' -f1`
realwanip=`ifconfig $waninterface |grep 'inet add'|awk -F ":" '{print $2}'|awk '{print $1}'`
echo ddns wan ip:$ddnswanip
echo real wan ip:$realwanip
if [ ${#realwanip} -gt 7 ]
then
        if [ "$realwanip" != "$ddnswanip" ] 
        then
                echo restarting noip2!
                killall noip2
                sleep 5
                /usr/noip/noip2 -c /usr/noip/noip2.conf
        fi
fi