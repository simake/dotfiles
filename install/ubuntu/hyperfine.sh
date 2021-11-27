#!/usr/bin/env bash

# https://github.com/sharkdp/hyperfine

wget -P /tmp/ https://github.com/sharkdp/hyperfine/releases/download/v1.12.0/hyperfine_1.12.0_amd64.deb
sudo dpkg -i /tmp/hyperfine_1.12.0_amd64.deb
rm /tmp/hyperfine_1.12.0_amd64.deb
