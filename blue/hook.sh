#!/bin/bash
# for every pic taken
if [[ $ARGUMENT =~ .+\.[jpg|JPG] ]];then
#if [ *$ACTION* = *Saving* ]; then
  # do a echo of the file name
  echo "Download: $ARGUMENT"
  # shot the picture in the current geeqie open
 cp $ARGUMENT latest.jpg
#  /usr/bin/geeqie --remote $ARGUMENT &
fi
