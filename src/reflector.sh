#!/bin/sh
# Load reflector daily
#

date=$(date +%D)
lastsync="$(cat ~/.config/reflector/.lastsync.txt)"

if [ "$date" != "$lastsync" ] ; then
sudo echo -e "\e[1m\e[34m::\e[0m\e[1m Updating mirrorlist ($date)...\e[0m"
> ~/.config/reflector/.lastsync.txt
echo $date >> ~/.config/reflector/.lastsync.txt
sudo reflector --country 'United States' -l 5 --sort rate --save /etc/pacman.d/mirrorlist
fi
exit
