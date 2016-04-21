a luci-app for ss-redir usage. with this UI, you can specify the IPs in the lan to be redired via ss-redir instead of whole lan.
--match-set $ipsetname, the ipsetname could be as an ipset which includes all IPs which is configured to be bypassed the redirecting, usually could get via following

wget -O- 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | awk -F\| '/CN\|ipv4/ { printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > /etc/ignore.list

