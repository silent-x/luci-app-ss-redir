#!/bin/sh 

. /lib/functions.sh

redir() {
        config_get_bool enabled "$1" 'enabled'
        config_get hostip "$1" 'hostip'
        config_get protocol "$1" 'protocol'
        config_get_bool matchipset "$1" 'matchipset'
        config_get ipsetname "$1" 'ipsetname'
        config_get toport "$1" 'toport'

        linenum=`iptables -t nat -L PREROUTING --line-number|grep $hostip|cut -d ' ' -f 1`
        if [ -n "$linenum" ]; then
                iptables -t nat -D PREROUTING $linenum
        fi 

        if [ "$enabled" = 1 ]; then
                if [ "$ipsetname" = 'null' ]; then
                        iptables -t nat -A PREROUTING -p $protocol -s $hostip/32 -j REDIRECT --to-port $toport
                else
            if [ "$matchipset" = 1 ]; then
                iptables -t nat -A PREROUTING -p $protocol -s $hostip/32 -m set --match-set $ipsetname dst -j REDIRECT --to-port $toport
            else
                iptables -t nat -A PREROUTING -p $protocol -s $hostip/32 -m set ! --match-set $ipsetname dst -j REDIRECT --to-port $toport
            fi
                fi

        fi
}

#iptables -t nat --flush PREROUTING
#iptables -t nat -A PREROUTING -j prerouting_rule
#iptables -t nat -A PREROUTING -j zone_lan_prerouting 
#iptables -t nat -A PREROUTING -j zone_wan_prerouting 


config_load 'ss-redir-ip'
config_foreach redir 'redirection'