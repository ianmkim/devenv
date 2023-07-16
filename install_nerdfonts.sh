#!/usr/bin/env bash

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip
mkdir Hack
cd Hack
unzip ../Hack.zip
cd ..
mkdir -p ~/.fonts
sudo cp Hack/* ~/.fonts

fc-cache -f -v
