#!/bin/bash

# Ghostty reads ~/.config/ghostty/config on both macOS and Linux.
mkdir -p ~/.config/ghostty/shaders

cp configs/ghostty/config ~/.config/ghostty/config
cp configs/ghostty/shaders/*.glsl ~/.config/ghostty/shaders/
echo "configuration installed"
