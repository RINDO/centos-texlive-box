## マニュアル設定

Vagrantファイル内の以下の行をコメントアウトする

```
config.vm.provision :shell, path: "provision.sh"
```

## 設定

Vagrantの立ち上げから、sshまで

```
$ vagrant up
$ vagrant ssh
[vagrant@localhost ~]$ su # pw: vagrant
```

必要なpackageのインストール

* perl : install-tlの実行に必要
* ImageMagick : texの画像ファイル

```
yum -y install perl ImageMagick
```

Texliveのインストール  

```
$ wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
$ tar xvzf install-tl-unx.tar.gz
$ cd install-tl-*
$ ./install-tl # Enter [I]
```

TexliveのPATHの設定

```
echo "export PATH=/usr/local/texlive/2016/bin/x86_64-linux/:$PATH" >> /etc/profile
source /etc/profile
```

tlmgrの設定

```
tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet
tlmgr update --self
tlmgr update --all
```