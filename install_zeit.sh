#!/usr/bin/env bash


git clone https://github.com/mrusme/zeit
cd zeit
make
sudo cp zeit /usr/local/bin
rm -rf zeit
