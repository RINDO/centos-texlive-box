# 必要環境

各コマンドをTerminalに貼り付けて実行する

## [必須]

* [Homebrew](http://brew.sh/index_ja.html)

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
--

* [Homebrew Cask](https://caskroom.github.io/)

VirtualBox, Vagrant, Vagrant Managerをインストールするのに使います。

Homebrew Caskを使わずにリンク先からダウンロードしても問題ありません。
HomebrewCaskでインストールすると管理が楽になります。

```
brew install caskroom/cask/brew-cask
```

--

* [VirtualBox](https://www.virtualbox.org/)

```
brew cask install virtualbox
```

--

* [Vagrant](https://www.vagrantup.com/)

```
brew cask install vagrant
```

## [オプション]

* [Vagrant Manager](http://vagrantmanager.com/)

Vagrantの操作をツールバー上で行うことができます。

```
brew cask install vagrant-manager
```

# Quick Install

まずはtex用のディレクトリを作成します 

```
$ mkdir tex
$ cd tex
$ vagrant init 
```

次に、Atlasに登録してあるvagrant boxを入手します。
Vagrantfileを以下のように編集してください。

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "RINDO/centos-texlive2016"
end
```

編集が終わったら、tex用のフォルダを作成します。

```
mkdir -p tex/source
```

最後に、以下のコマンドを叩いてboxをダウンロードしてください。

```
$ vagrant up
$ vagrant ssh
```

`vagrant ssh` 以下は下記の手順で操作可能です。

# Texコンパイルまで

まずは、Githubからリポジトリをcloneしてtexフォルダ内に自分のtexファイルや画像を入れます。

```
$ cd $$PROJECT_PATH$$
$ git clone git@github.com:RINDO/centos-texlive2016-box.git
$ cd centos-tex-box
$ cp -R $$TEX_DIR$$ $$PROJECT_DIR$$/centos-tex-box/tex
```

## Vagrantの設定

次に、Vagrantを操作して仮想マシンの初期設定を行っていきます。

```
$ vagrant up
```

`vagrant up` が終了したら、仮想マシンに`ssh`してtexのコンパイルを行います。

```
$ vagrant ssh
$ cd /vagrant/tex
$ platex $$TEX_FILE$$.tex
$ dvipdfmx $$TEX_FILE$$.dvi
```

# 備考

## フォルダの同期

Hostマシンの `./tex/source` フォルダは、 Vagrant上の `/vagrant/tex` に同期されます。

```
config.vm.synced_folder "./tex/source", "/vagrant/tex"
```

## VirtualBoxのエラーが出たら

VirtualBoxのVersionが新しいと、 `vagrant up` したときに以下のエラーが出てしまいます。 

```
The provider 'virtualbox' that was requested to back the machine
'default' is reporting that it isn't usable on this system. The
reason is shown below:

Vagrant has detected that you have a version of VirtualBox installed
that is not supported by this version of Vagrant. Please install one of
the supported versions listed below to use Vagrant:

4.0, 4.1, 4.2, 4.3, 5.0

A Vagrant update may also be available that adds support for the version
you specified. Please check www.vagrantup.com/downloads.html to download
the latest version.
```

上記のエラーが出たら、以下のリンクから古いものをインストールしましょう。  `brew cask` でインストールしたものは消しておきます。

```
brew cask uninstall virtualbox
```

[Download VirtualBox (Old Builds)](https://www.virtualbox.org/wiki/Download_Old_Builds)


## "VirtualBox.pkg"を検証中.. で止まってしまった場合

![検証中](https://cloud.githubusercontent.com/assets/2969018/16825368/2738dc88-49af-11e6-84ef-0b2527285c43.png)

[こののページ](https://forums.virtualbox.org/viewtopic.php?f=8&t=77122)を参考にしてください。

マウントした状態で以下のコマンドを入力するとインストールできるようになります。 

```
sudo installer -package /Volumes/VirtualBox/VirtualBox.pkg -target /
```