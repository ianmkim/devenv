#!/usr/bin/bash

git clone https://github.com/vim/vim.git
cd vim/src
./configure --with-features=huge --enable-python3interp
make -j
sudo make install
sudo rm /usr/local/bin/vim
sudo mv vim /usr/local/bin/vi

git clone --depth=1 https://github.com/ianmkim/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vim.sh

