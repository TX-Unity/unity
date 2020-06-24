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


echo "Add Repositry"
# telegram repository
add-apt-repository -y ppa:atareao/telegram  >/dev/null 2>&1
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C >/dev/null 2>&1
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ACCAF35C >/dev/null 2>&1
# insync repository
echo "deb http://apt.insync.io/ubuntu focal non-free contrib" >> /etc/apt/sources.list.d/insync.list
echo "Updating Repositry"
apt -qq update >/dev/null 2>&1
echo "Installing Packages"
echo "Bitwarden, entangle, vlc, telegram, insync, gphoto2, geeqie, vlc"
snap install bitwarden >/dev/null 2>&1
cd /tmp
apt install -y entangle gphoto2 geeqie vlc build-essential dkms git telegram wget insync python3-wxgtk4.0 >/dev/null 2>&1
echo "Installing Angry Ip Scanner"
#angry ip scanner
wget -q https://github.com/angryip/ipscan/releases/download/3.7.2/ipscan_3.7.2_amd64.deb >/dev/null 2>&1
#teamviewer
echo "Installing Teamviewer"
wget -q https://download.teamviewer.com/download/linux/teamviewer_amd64.deb >/dev/null 2>&1
dpkg -i teamviewer_amd64.deb >/dev/null 2>&1
dpkg -i ipscan_3.7.2_amd64.deb >/dev/null 2>&1
apt install -f -y >/dev/null 2>&1
apt install -f -y >/dev/null 2>&1
# remove all deb
rm -rf /tmp/*.deb >/dev/null 2>&1
echo "Script finish"
