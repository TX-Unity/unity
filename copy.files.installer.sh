#!/bin/bash

blue_password="superBLUE"
red_password="superRED"
green_password="superGREEN"







if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root"
   	exit 1
fi

echo "Creating Users:"
echo "  blue, red, green"
useradd -m -s /bin/bash blue >/dev/null 2>&1
useradd -m -s /bin/bash red >/dev/null 2>&1
useradd -m -s /bin/bash green >/dev/null 2>&1
echo -e "$blue_password\n$blue_password\n" | passwd blue >/dev/null 2>&1
echo -e "$red_password\n$red_password\n" | passwd red >/dev/null 2>&1
echo -e "$green_password\n$green_password\n" | passwd green >/dev/null 2>&1


ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
FOLDER=$(dirname "${ABSOLUTE_PATH}")
#echo $ABSOLUTE_PATH
cd "$FOLDER"
#username=$(getent passwd 1000 | cut -d: -f1)
#userhome="/home/$username"
#chmod +x Applications/*
my_array=(blue green red)
for i in "${my_array[@]}"
do
  rm -r /home/$i/Desktop/Applications >/dev/null 2>&1
  mkdir /home/$i/Desktop/ >/dev/null 2>&1
  cp -avrp $i/ /home/$i/Desktop/Applications >/dev/null 2>&1
  cp -p $i/*.desktop /home/$i/Desktop/ >/dev/null 2>&1
  chown $i:$i -R /home/$i/Desktop
  chmod +x -R /home/$i/Desktop

done
