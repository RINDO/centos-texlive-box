# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  # boxにはbentoのcentos6.7を使用
  config.vm.box = "bento/centos-7.2"

  # texフォルダにtexファイルを入れる
  config.vm.synced_folder "./tex", "/vagrant/tex"

  # provision.shでcentos用のtex環境を整える
  config.vm.provision :shell, path: "provision.sh"

end
