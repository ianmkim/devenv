#!/usr/bin/env bash

sudo apt-get install -y git cmake gettext repgrep fd-find
git clone https://github.com/neovim/neovim
cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=Release
sudo make install
