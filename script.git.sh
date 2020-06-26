
downloadin="/tmp/script.from.git"

rm -rf $downloadin
if [ -f /usr/bin/git ]; then
  echo "Stating script"
else
  if [ "$EUID" -ne 0 ]; then
    echo "You dont have GIT installed in this system"
    echo "Please run as root to fix this problem"
    exit
  else
    echo "Installing Git, please wait"
    apt-get -y install git git-core >/dev/null 2>&1
  fi
fi
echo "Download repository"
git clone https://github.com/TX-Unity/unity $downloadin >/dev/null 2>&1


if [ "$EUID" -ne 0 ]; then
  # if im a normal user
  username=$(whoami)
  echo "im $username"
  cd $downloadin
  cp -avrp $downloadin/$username/* $HOME/Desktop/Applications >/dev/null 2>&1
  cp -p $downloadin/$username/*.desktop $HOME/Desktop/ >/dev/null 2>&1
  chown $username:$username -R $HOME/Desktop
  chmod +x -R $HOME/Desktop
else
  # if im root, update from everyone
  chmod +x $downloadin/copy.files.installer.sh
  $downloadin/copy.files.installer.sh

fi
echo "Script end"
rm -rf $downloadin
