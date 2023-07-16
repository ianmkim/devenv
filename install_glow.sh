#!/usr/bin/env bash

git clone https://github.com/charmbracelet/glow.git
cd glow
go build
sudo cp ./glow /usr/local/bin
