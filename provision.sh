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

  expect \"Time used for installing the packages:\"
  send \"exit 1\"
"

echo "export PATH=/usr/local/texlive/2016/bin/x86_64-linux/:$PATH" >> /etc/profile
source /etc/profile

#
# tlmgr: package repository ftp://ftp.u-aizu.ac.jp/pub/tex/CTAN/systems/texlive/tlnet (verified)
# tlmgr: backupdir as set in tlpdb
#   /usr/local/texlive/2016/tlpkg/backups
# is not a directory.
# 

mkdir /usr/local/texlive/2016/tlpkg/backups

echo "Setting tlmgr repository"
tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet

echo "Updating tlmgr"
tlmgr update --self

echo "Updating tlmgr packages"
tlmgr update --all

echo "Finished!"
