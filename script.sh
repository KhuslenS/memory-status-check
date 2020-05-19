#!/bin/bash
##############################
#Script Name            : script.sh
#Description            : send alert to email when server memory is low
##############################
##email subject
subject="Server Memory Status alert"
##sending mail as
from="email@email.com"
##
to="admin@email.com"
##
also_to="engineer@email.com"

##get total free memory size in megabytes(MB)
free=$(free -mt | gret Total | awk '{print $4}')

##check if free memory is less or equals to 100MB
if [[ "$free" -le 100 ]]; then
    ##get top processes consuming system memory and save to tmp file
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head > /tmp/consuming_memory.txt

    file=/tmp/consuming_memory.txt
    ##send email if system memory is running low
    echo -e "warning server memory is running low!\n\nFree memory: $free MB" | mailx -a "$file" -s "$subject" -r "$from" -c "$to" "$also_to"
fi

exit 0 