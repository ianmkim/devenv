#!/usr/bin/env bash

# Installs the NNN file system

sudo apt-get install libreadline-dev -y
git clone git@github.com:jarun/nnn.git
cd nnn
make
sudo make install

