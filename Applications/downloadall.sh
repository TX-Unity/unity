#!/bin/bash

# select where create subfolders
store_photos_in="$HOME/nikon"
# create now variable with date values
now=$(date +'%m-%d-%Y.%H.%M.%S')
# just a message
echo "Download all photos in $store_photos_in"

# create the folder inside store_photo path dir and make the folder name
# as same as date
mkdir -p "$store_photos_in"


pkill -f gphoto2
pkill -f gphoto

# go to  the new folder created and process do dowload all photos
cd "$store_photos_in" && gphoto2 --get-all-files --skip-existing

geeqie "$store_photos_in" &
read -p "Enter to exit"
