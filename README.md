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

# Texコンパイルまで

まずは、Githubからリポジトリをcloneしてtexフォルダ内に自分のtexファイルや画像を入れます。

```
$ cd $$PROJECT_PATH$$
$ git clone git@github.com:RINDO/centos-texlive2016-box.git
$ cd centos-tex-box
$ cp -R $$TEX_DIR$$ $$PROJECT_DIR$$/centos-tex-box/tex
```

## Vagrantの設定

### 手動

手動で設定を行いたい人は [手動での設定](https://github.com/RINDO/centos-texlive2016-box/blob/master/manual_install.md) を参考にしてください。

自動で設定する人は以下に進んでください。

### 自動

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
