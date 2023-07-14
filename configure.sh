#!/usr/bin/env bash

sudo apt-get install tmux

./install_alacritty.sh

mkdir -p ~/.config/alacritty 
cp configs/alacritty.yml ~/.config/alacritty
cp configs/tmux.conf ~/.tmux.conf
