#!/bin/bash

# Remove tunnel as default routes for table international
sudo ip route del $untrusted_ip via $route_net_gateway dev eth0 table 2
sudo ip route del $eth0_network dev eth0 proto dhcp scope link src $eth0_ip metric 202 table 2

# Remove SNAT for packages routed via the tunnel
sudo iptables -t nat -D POSTROUTING -o $dev -j MASQUERADE