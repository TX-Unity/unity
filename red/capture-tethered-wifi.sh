#!/bin/bash

# select where create subfolders
store_photos_in="$HOME/nikon"
camera_model="Nikon DSC D7200"
camera_ip="192.168.1.1"
# create now variable with date values
now=$(date +'%m-%d-%Y.%H.%M.%S')
now=$(date +'%m-%d-%Y')




echo "Conecting to $camera_model on $camera_ip"
# just a message
echo "Tether photos to $store_photos_in"

# create the folder inside store_photo path dir and make the folder name
# as same as date
mkdir -p $store_photos_in

# killall process with gphoto to avoid error on device busy
# problem with claim device
# https://askubuntu.com/questions/993876/gphoto2-could-not-claim-the-usb-device
pkill -f gphoto2
pkill -f gphoto


cd "$store_photos_in" && gphoto2 --port ptpip:$camera_ip --camera="$camera_model" --capture-tethered --hook-script=$HOME/Desktop/Applications/hook.sh --keep
#cd "$store_photos_in/tethered-$now" && gphoto2 --port ptpip:$camare_ip --camera '$camera_model' --capture-tethered --hook-script=$HOME/Desktop/Applications/hook.sh
#cd "$store_photos_in" && gphoto2 --keep --port ptpip:$camera_ip --camera="$camera_model" --capture-tethered --hook-script=$HOME/Desktop/Applications/hook.sh

# go to  the new folder created and process capture-tethered
# just a message
echo "Tether photos to $store_photos_in"

