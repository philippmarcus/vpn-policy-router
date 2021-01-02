#!/bin/bash

# Configure tunnel as default routes for table international
sudo ip route add 0.0.0.0/1 via $route_vpn_gateway dev $dev table 2
sudo ip route add 128.0.0.0/1 via $route_vpn_gateway dev $dev table 2

# SNAT for packages routed via the tunnel
sudo iptables -t nat -A POSTROUTING -o $dev -j MASQUERADE