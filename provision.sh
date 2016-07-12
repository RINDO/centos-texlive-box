#
# Texlive guide
# http://www.fugenji.org/~thomas/texlive-guide/
#

echo "Installing yum packages"

echo "Installing perl"
yum -y install perl

echo "Installing expect"
yum -y install expect

echo "Installing ImageMagick"
yum -y install ImageMagick

# 
# install Texlive for Linux
# https://texwiki.texjp.org/?TeX%20Live#v9c33c6a
#

echo "Dowinloading Texlive for linux. Maybe take about 30 minutes."
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar xvzf install-tl-unx.tar.gz
cd install-tl-*

#
# install-tl : TeX Live cross-platform installer
# https://www.tug.org/texlive/doc/install-tl.html
#

echo "Installing Texlive. Take about 30 minutes."
expect -c "
  set timeout -1
  spawn ./install-tl
  
  expect \"Enter command:\"
  send  \"I\r\"

  expect \"Installation failed.\"
  send \"./install-tl --profile installation.profile\"

  expect \"Do you want to continue with the exact same settings as before (y/N):\"
  send \"y\"

  expect \"Time used for installing the packages:\"
  send \"exit 1\"
"

echo "export PATH=/usr/local/texlive/2016/bin/x86_64-linux/:$PATH" >> /etc/profile
source /etc/profile

echo "Setting tlmgr repository"
tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet

echo "Updating tlmgr"
tlmgr update --self

echo "Updating tlmgr packages"
tlmgr update --all

echo "Finished!"
