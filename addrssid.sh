#!/usr/bin/sh
# This file will store whether to display ip or ssid
tmp_file="$HOME/.cache/addrssid"

# Make sure file exists
touch $tmp_file

if [ -z $(cat $tmp_file) ]
then
    # First print SSID
    printf $(nmcli -t -f active,ssid dev wifi | grep -G ^yes | cut -d\: -f2)
    printf "1" > $tmp_file
else
    # When click print ip

    printf $(ip -brief addr | grep wlo1 | awk '{print $3}' | grep -Go --color=no "^[^/]*")
    printf "" > $tmp_file
fi
