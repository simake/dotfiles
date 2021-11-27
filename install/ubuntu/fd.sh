#!/usr/bin/env bash

# https://github.com/sharkdp/fd

wget -P /tmp/ https://github.com/sharkdp/fd/releases/download/v8.3.0/fd_8.3.0_amd64.deb
sudo dpkg -i /tmp/fd_8.3.0_amd64.deb
rm /tmp/fd_8.3.0_amd64.deb
