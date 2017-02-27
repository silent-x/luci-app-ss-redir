#!/bin/sh

#echo $1
if [ ! -f "$1" ]; then 
        echo "Config $1 Not Found!"
        exit 1
fi

ConfigDir=`dirname $1`
ConfigFilename=`basename $1`

if [ "$ConfigFilename" = "config.json" ]; then
        echo "config.json is not supported."
        exit 1
fi

/etc/init.d/shadowsocksr stop

rm $ConfigDir/config.json
ln $1 $ConfigDir/config.json -s

sleep 3

/etc/init.d/shadowsocksr start