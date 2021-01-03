#!/bin/bash

# Abort if an error occurs during script execution
set -e

# Remove tunnel as default routes for table international
ip route del $untrusted_ip via $route_net_gateway dev eth0 table 2
ip route del $eth0_network dev eth0 proto dhcp scope link src $eth0_ip metric 202 table 2

# Remove SNAT for packages routed via the tunnel
iptables -t nat -D POSTROUTING -o $dev -j MASQUERADE