#!/usr/bin/env bash

sudo apt-get install -y git cmake
git clone https://github.com/vim/vim.git
cd vim && git checkout v8.0.1850
./configure
cd src
sudo make install
cd ../../
# I like calling vi instead of vim for vim
sudo mv /usr/local/bin/vim /usr/local/bin/vi
