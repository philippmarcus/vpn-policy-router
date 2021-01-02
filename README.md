# Traffic Split VPN routing on a Raspberry Pi with Policy Routing 

This repostitory contains the scripts for the vpn traffic split vpn routing tutorial on my website: [https://philippmarcus.github.io/vpn-policy-router/](https://philippmarcus.github.io/vpn-policy-router/)


The scripts in this repository set-up a Raspberry Pi based solution for a VPN traffic split router. The Raspberry Pi coexists as a router in the same subnet as the WAN internet router and can be used as a router by individual devices if required. This allows in the best case to consume both, domestic and international streaming/media content all without geolocation restrictions. Roughly, the solution works as follows:

- Packets received from the home network and to be routed to the internet are marked with a `marker` 2 or 3 depending on the destination country
- A separate routing table is created for both markers, using either the tunnel or the local home router

The charm of the solution is that the existing WLAN can continue to be used unchanged. Additionally, the Raspberry Pi is available as an alternative router for individual devices that require the VPN traffic split functionality. Drawbacks are potential DNS leaks if a domestic DNS server is used, or geolocation blocks imposed on domestic websites if an international DNS server is used.

## Contents

This repostirory contains the following files:

```
.
├── LICENSE
├── README.md (this readme)
├── default_network.sh (network config at boot time)
├── down.sh (OpenVPN down script)
└── up.sh (OpenVPN up script)
```

## Requirements

As described in the article, the scripts have the following requirements:

- Raspberry Pi or a comparable another Linux box
- OpenVPN
- The package `ipcalc`

## Installation

- Execute the script `default_network.sh` at boot time
- Add the lines `up up.sh` and `down down.sh` to your OpenVPN connection configuration files