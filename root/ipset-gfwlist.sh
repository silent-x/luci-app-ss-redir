#!/bin/sh

lineCount=`ipset list gfwlist | wc -l`

if [ $lineCount -eq 0  ]; then
        ipset create gfwlist hash:net
else
        ipset flush gfwlist
fi

ipset add gfwlist 192.168.0.0/16
ipset add gfwlist 0.0.0.0/8
ipset add gfwlist 10.0.0.0/8
ipset add gfwlist 127.0.0.0/8
ipset add gfwlist 169.254.0.0/16
ipset add gfwlist 172.16.0.0/12
ipset add gfwlist 224.0.0.0/4
ipset add gfwlist 240.0.0.0/4


lineCount=`cat /etc/chinadns_chnroute.txt | wc -l`
lastUpdateTime=`stat -c %Y /etc/chinadns_chnroute.txt`
nowTime=`date +%s`

#if [ $lineCount -eq 0  ] || [ $(( $nowTime - $lastUpdateTime )) -gt 86400 ]; then
if [ $lineCount -eq 0  ]; then
        wget -O- 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | awk -F\| '/CN\|ipv4/ { printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > /etc/chinadns_chnroute.txt
fi

lineCount=`cat /etc/chinadns_chnroute.txt | wc -l`

if [ $lineCount -ne 0  ]; then
        for  i  in  `cat /etc/chinadns_chnroute.txt`
        do
                ipset add gfwlist $i
        done
fi