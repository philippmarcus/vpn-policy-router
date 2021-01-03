#!/bin/bash

# Abort if an error occurs during script execution
set -e

# CONFIG parameters
router_ip="192.168.0.1"
dev="eth0"
home_country_code="DE"

# Derive the subnet for eth0
dev_subnet_cidr=$(ipcalc $(ip -o -f inet addr show $dev | awk '/scope global/ {print $4}') | awk '/Network:/ {print $2}')

###################################
# Part 1: Define the routing tables
###################################

# routing table for IP packets towards international destinations
ip rule add fwmark 2 table 2 prio 15000

# routing table for IP packets towards domestic destinations
ip rule add fwmark 3 table 3 prio 15100

#############################
# Part 2: Marking in IPTables
#############################

# mark outgoing packages to international destinations (outside of Germany) with marker 2
iptables -A PREROUTING -t mangle -m geoip ! --dst-cc $home_country_code -i $dev -j MARK --set-mark 2

# mark outgoing packages to domestic locations (Germany in my case) with marker 3
iptables -A PREROUTING -t mangle -m geoip --dst-cc $home_country_code -i $dev ! -d $dev_subnet_cidr -j MARK --set-mark 3

###################################
# Part 3: Routing Commands
###################################

# Prohibit packets towards international destinations (overriden by up.sh)
ip route add prohibit default table 2

# Route for domestic packets
ip route add default table 3 via $router_ip dev $dev