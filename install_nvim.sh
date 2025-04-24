#!/usr/bin/env bash

sudo apt-get install -y git cmake gettext ripgrep fd-find fzf
git clone https://github.com/neovim/neovim
cd neovim && git checkout release-0.10 && make CMAKE_BUILD_TYPE=Release
sudo make install
