#!/bin/bash

# Abort if an error occurs during script execution
set -e

git clone https://git.inai.de/xtables-addons
cd xtables-addons

autoreconf -i

./configure
make
make install

# Index newly created modules
depmod -a

# Load the xt_geoip module for this session
modprobe xt_geoip

# Ensure the module will always be loaded at boot
echo xt_geoip >> /etc/modules-load.d/modules.conf