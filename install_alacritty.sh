#!/usr/bin/env bash
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxkbcommon-dev python3

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

rustup override set stable
rustup update stable

git clone https://github.com/alacritty/alacritty.git
cd alacritty

cargo build --release
sudo cp alacritty/target/release/alacritty /usr/local/bin # or anywhere else in $PATH

infocmp alacritty
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

sudo cp alacritty/extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install alacritty/extra/linux/Alacritty.desktop
sudo update-desktop-database



