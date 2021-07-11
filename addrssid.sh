#!/usr/bin/sh
# This file will store whether to display ip or ssid
tmp_file="$HOME/.cache/addrssid"

# Make sure file exists
touch $tmp_file

# Check if the file has anything
file_contents=1
if [ -z $(cat $tmp_file) ]; then file_contents=0; fi

# Switch state of file if no arguments are passed
if [ $# -eq 0 ]
then
    if [ $file_contents -eq 0 ]
    then
        printf "1" > $tmp_file
        file_contents=1
    else
        printf "" > $tmp_file
        file_contents=0
    fi
fi

# If string is empty there is no wifi
text="No Wife"

if [ $file_contents -eq 0 ]
then
    # First print SSID
    temp=$(nmcli -t -f active,ssid dev wifi | grep -G ^yes | cut -d\: -f2)
else
    # When click print ip
    temp=$(ip -brief addr | grep wlo1 | awk '{print $3}' | grep -Go --color=no "^[^/]*")
fi

# If the text isnt empty (theres a wifi connection) then display the ip
# or SSID, else "No Wifi"
if [ "$temp" != "" ]
then
    text=$temp
fi

printf "$text"
