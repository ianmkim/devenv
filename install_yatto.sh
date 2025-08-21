#!/usr/bin/env bash

wget https://github.com/handlebargh/yatto/releases/download/v0.15.0/yatto_Linux_x86_64.tar.gz
mkdir -p install
cd install
tar -xvf yatto_Linux_x86_64.tar.gz
sudo mv yatto /usr/local/bin
cd ..
cp -r config/yatto ~/.config
