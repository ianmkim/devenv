#!/usr/bin/bash

git clone https://github.com/vim/vim.git
cd vim/src
./configure --with-features=huge --enable-python3interp
make -j
sudo make install
sudo rm /usr/local/bin/vim
sudo mv vim /usr/local/bin/vi

cp vimrc ~/.vimrc
