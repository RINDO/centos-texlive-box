#
# Texlive guide
# http://www.fugenji.org/~thomas/texlive-guide/
#

# rsync -a rsync://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/telnet/ .

echo "updating yum"
yum -y update >> /dev/null

echo "Installing rsync"
yum -y install rsync >> dev/null

echo "Installing perl"
yum -y install perl >> /dev/null
sudo yum -y install perl-Digest-MD5 >> /dev/null

echo "Installing expect"
yum -y install expect >> /dev/null

echo "Installing ImageMagick"
yum -y install ImageMagick >> /dev/null

# 
# install Texlive for Linux
# https://texwiki.texjp.org/?TeX%20Live#v9c33c6a
#

echo "Dowinloading Texlive for linux. Maybe take about 30 minutes."
if [ ! -e 'install-tl-unx.tar.gz' ]; then
  rsync -r rsync://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz .
  tar xvzf install-tl-unx.tar.gz
fi

# install-tl-20161115
cd install-tl-*

#
# install-tl : TeX Live cross-platform installer
# https://www.tug.org/texlive/doc/install-tl.html
#

if [ ! -e '/usr/local/texlive/']; then
  echo "Installing Texlive. Take about 30 minutes."
  expect -c "
    set timeout -1
    spawn ./install-tl
    
    expect \"Enter command:\"
    send  \"I\r\"

    expect \"Time used for installing the packages:\"
    send \"exit 1\"
  "

  cd /usr/local/texlive/20*/
  TEX_PATH=$(pwd)

  echo "export PATH=${TEX_PATH}/bin/x86_64-linux/:$PATH" >> /etc/profile
  source /etc/profile

  mktexlsr >> /dev/null

  #
  # tlmgr: package repository ftp://ftp.u-aizu.ac.jp/pub/tex/CTAN/systems/texlive/tlnet (verified)
  # tlmgr: backupdir as set in tlpdb
  #   /usr/local/texlive/20**/tlpkg/backups
  # is not a directory.
  # 
  mkdir -p ${TEX_PATH}/tlpkg/backups
  chmod -R a+w ${TEX_PATH}/tlpkg/backups

  echo "Setting tlmgr repository"
  tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet >> /dev/null

  echo "Updating tlmgr"
  tlmgr update --self >> /dev/null

  echo "Updating tlmgr packages"
  tlmgr update --all >> /dev/null

  echo "Finished!"
fi
