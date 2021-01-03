#!/bin/bash

# Abort if an error occurs during script execution
set -e

# Configure tunnel as default routes for table international
ip route add 0.0.0.0/1 via $route_vpn_gateway dev $dev table 2
ip route add 128.0.0.0/1 via $route_vpn_gateway dev $dev table 2

# SNAT for packages routed via the tunnel
iptables -t nat -A POSTROUTING -o $dev -j MASQUERADE